import Foundation
import AVFoundation
import Metal

public protocol CameraDelegate: class {
    func didCaptureBuffer(_ sampleBuffer: CMSampleBuffer)
}

public enum PhysicalCameraLocation {
    case backFacing
    case frontFacing
    
    func imageOrientation() -> ImageOrientation {
        switch self {
            case .backFacing: return .portrait
#if os(iOS)
            case .frontFacing: return .portrait
#else
            case .frontFacing: return .portrait
#endif
        }
    }
    
    func captureDevicePosition() -> AVCaptureDevice.Position {
        switch self {
        case .backFacing: return .back
        case .frontFacing: return .front
        }
    }
    
    public func device() -> AVCaptureDevice? {
        if let device = AVCaptureDevice.default(.builtInDualCamera,
                                                for: .video, position: self.captureDevicePosition()) {
            return device
        } else if let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                       for: .video, position: self.captureDevicePosition()) {
            return device
        } else {
            return AVCaptureDevice.default(for: AVMediaType.video)
        }
    }
}

public enum CameraError: Error, CustomStringConvertible {
    case avCaptureDeviceNotFound
    
    public var errorDescription:String {
        switch self {
        case .avCaptureDeviceNotFound:
            return "The AVCaptureDevice could not be found. Camera is not supported on Simulator."
        }
    }
    
    public var description:String {
        return "<\(type(of: self)): errorDescription = \(self.errorDescription)>"
    }
}

let initialBenchmarkFramesToIgnore = 5


public class Camera: NSObject, ImageSource, AVCaptureVideoDataOutputSampleBufferDelegate,
    AVCaptureAudioDataOutputSampleBufferDelegate {

    public var location:PhysicalCameraLocation {
        didSet {
            // TODO: Swap the camera locations, framebuffers as needed
        }
    }
    public var runBenchmark:Bool = false
    public var logFPS:Bool = false
    
    public var audioEncodingTarget:AudioEncodingTarget? {
        didSet {
            guard let audioEncodingTarget = audioEncodingTarget else {
                return
            }
            do {
                try self.addAudioInputsAndOutputs()
                audioEncodingTarget.activateAudioTrack()
            } catch {
                Log.error("Could not connect audio target with error: \(error)")
            }
        }
    }
    
    public let targets = TargetContainer()
    public weak var delegate: CameraDelegate?
    public let captureSession:AVCaptureSession
    public var orientation:ImageOrientation?
    public let inputCamera:AVCaptureDevice!
    public let videoInput:AVCaptureDeviceInput!
    public let videoOutput:AVCaptureVideoDataOutput!
    var videoTextureCache: CVMetalTextureCache?
    public var microphone:AVCaptureDevice?
    public var audioInput:AVCaptureDeviceInput?
    public var audioOutput:AVCaptureAudioDataOutput?
    
    var supportsFullYUVRange:Bool = false
    let captureAsYUV:Bool
    let yuvConversionRenderPipelineState:MTLRenderPipelineState?
    var yuvLookupTable:[String:(Int, MTLStructMember)] = [:]
    var yuvBufferSize:Int = 0
    
    let frameRenderingSemaphore = DispatchSemaphore(value:1)
    let cameraFrameProcessingQueue = DispatchQueue(label: "com.sunsetlakesoftware.GPUImage.cameraFrameProcessingQueue")
    let cameraAudioProcessingQueue = DispatchQueue(label: "com.sunsetlakesoftware.GPUImage.cameraAudioProcessingQueue")
    
    let framesToIgnore = 5
    var numberOfFramesCaptured = 0
    var totalFrameTimeDuringCapture:Double = 0.0
    var framesSinceLastCheck = 0
    var lastCheckTime = CFAbsoluteTimeGetCurrent()
    
    public init(sessionPreset:AVCaptureSession.Preset, cameraDevice:AVCaptureDevice? = nil, location:PhysicalCameraLocation = .backFacing, orientation:ImageOrientation? = nil, captureAsYUV:Bool = true) throws {
        self.location = location
        self.orientation = orientation

        self.captureSession = AVCaptureSession()
        self.captureSession.beginConfiguration()
        
        self.captureAsYUV = captureAsYUV
        
        if let cameraDevice = cameraDevice {
            self.inputCamera = cameraDevice
        } else {
            if let device = location.device() {
                self.inputCamera = device
            } else {
                self.videoInput = nil
                self.videoOutput = nil
                self.inputCamera = nil
                self.yuvConversionRenderPipelineState = nil
                super.init()
                throw CameraError.avCaptureDeviceNotFound
            }
        }
        
        do {
            self.videoInput = try AVCaptureDeviceInput(device:inputCamera)
        } catch {
            self.videoInput = nil
            self.videoOutput = nil
            self.yuvConversionRenderPipelineState = nil
            super.init()
            throw error
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        }
        
        // Add the video frame output
        videoOutput = AVCaptureVideoDataOutput()
        videoOutput.alwaysDiscardsLateVideoFrames = false
        
        if captureAsYUV {
            supportsFullYUVRange = false
            // Temporarily disabled due to Xcode 12 Simulator bug preventing access to availableVideoPixelFormatTypes https://twitter.com/MartinPucik/status/1306149902406356992
            //let supportedPixelFormats = videoOutput.availableVideoPixelFormatTypes
            //for currentPixelFormat in supportedPixelFormats {
            //    if ((currentPixelFormat as NSNumber).int32Value == Int32(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)) {
            //        supportsFullYUVRange = true
            //    }
            //}
            if (supportsFullYUVRange) {
                let (pipelineState, lookupTable, bufferSize) = generateRenderPipelineState(device:sharedMetalRenderingDevice, vertexFunctionName:"twoInputVertex", fragmentFunctionName:"yuvConversionFullRangeFragment", operationName:"YUVToRGB")
                self.yuvConversionRenderPipelineState = pipelineState
                self.yuvLookupTable = lookupTable
                self.yuvBufferSize = bufferSize
                videoOutput.videoSettings = [/*kCVPixelBufferMetalCompatibilityKey as String: true,*/
                                             kCVPixelBufferPixelFormatTypeKey as String:NSNumber(value:Int32(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange))]
            } else {
                let (pipelineState, lookupTable, bufferSize) = generateRenderPipelineState(device:sharedMetalRenderingDevice, vertexFunctionName:"twoInputVertex", fragmentFunctionName:"yuvConversionVideoRangeFragment", operationName:"YUVToRGB")
                self.yuvConversionRenderPipelineState = pipelineState
                self.yuvLookupTable = lookupTable
                self.yuvBufferSize = bufferSize
                videoOutput.videoSettings = [/*kCVPixelBufferMetalCompatibilityKey as String: true,*/
                                             kCVPixelBufferPixelFormatTypeKey as String:NSNumber(value:Int32(kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange))]
            }
        } else {
            self.yuvConversionRenderPipelineState = nil
            videoOutput.videoSettings = [/*kCVPixelBufferMetalCompatibilityKey as String: true,*/
                                         kCVPixelBufferPixelFormatTypeKey as String:NSNumber(value:Int32(kCVPixelFormatType_32BGRA))]
        }

        if (captureSession.canAddOutput(videoOutput)) {
            captureSession.addOutput(videoOutput)
        }
        
        captureSession.sessionPreset = sessionPreset
        
        var captureConnection: AVCaptureConnection!
        for connection in videoOutput.connections {
            for port in connection.inputPorts {
                if port.mediaType == AVMediaType.video {
                    captureConnection = connection
                    captureConnection.isVideoMirrored = location == .frontFacing
                }
            }
        }
        
        if captureConnection.isVideoOrientationSupported {
            captureConnection.videoOrientation = .portrait
        }
        
        captureSession.commitConfiguration()
        
        super.init()
        
        let _ = CVMetalTextureCacheCreate(kCFAllocatorDefault, nil, sharedMetalRenderingDevice.device, nil, &videoTextureCache)

        videoOutput.setSampleBufferDelegate(self, queue:cameraFrameProcessingQueue)
    }
    
    deinit {
        // Don't call this on the cameraFrameProcessingQueue otherwise you may get a deadlock since this waits for the captureOutput() delegate call to finish.
        self.stopCapture()
        
        self.videoOutput?.setSampleBufferDelegate(nil, queue:nil)
        self.audioOutput?.setSampleBufferDelegate(nil, queue:nil)
    }
    
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard (output != audioOutput) else {
            self.processAudioSampleBuffer(sampleBuffer)
            return
        }

        let startTime = CFAbsoluteTimeGetCurrent()

        guard (frameRenderingSemaphore.wait(timeout:DispatchTime.now()) == DispatchTimeoutResult.success) else { return }
        
        autoreleasepool {
            let cameraFrame = CMSampleBufferGetImageBuffer(sampleBuffer)!
            
            CVPixelBufferLockBaseAddress(cameraFrame, [])
            
            let bufferWidth = CVPixelBufferGetWidth(cameraFrame)
            let bufferHeight = CVPixelBufferGetHeight(cameraFrame)
            let currentTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
            
            self.delegate?.didCaptureBuffer(sampleBuffer)
            
            CVPixelBufferUnlockBaseAddress(cameraFrame, [])
            
            let texture:Texture?
            if self.captureAsYUV {
                var luminanceTextureRef:CVMetalTexture? = nil
                var chrominanceTextureRef:CVMetalTexture? = nil
                // Luminance plane
                let _ = CVMetalTextureCacheCreateTextureFromImage(kCFAllocatorDefault, self.videoTextureCache!, cameraFrame, nil, .r8Unorm, bufferWidth, bufferHeight, 0, &luminanceTextureRef)
                // Chrominance plane
                let _ = CVMetalTextureCacheCreateTextureFromImage(kCFAllocatorDefault, self.videoTextureCache!, cameraFrame, nil, .rg8Unorm, bufferWidth / 2, bufferHeight / 2, 1, &chrominanceTextureRef)
                
                let outputWidth:Int
                let outputHeight:Int
                if (self.orientation ?? self.location.imageOrientation()).rotationNeeded(for:.portrait).flipsDimensions() {
                    outputWidth = bufferHeight
                    outputHeight = bufferWidth
                } else {
                    outputWidth = bufferWidth
                    outputHeight = bufferHeight
                }
                
                if let concreteLuminanceTextureRef = luminanceTextureRef,
                    let concreteChrominanceTextureRef = chrominanceTextureRef,
                    let luminanceTexture = CVMetalTextureGetTexture(concreteLuminanceTextureRef),
                    let chrominanceTexture = CVMetalTextureGetTexture(concreteChrominanceTextureRef),
                    let outputTexture = Texture(device:sharedMetalRenderingDevice.device, orientation:.portrait, width:outputWidth, height:outputHeight, timingStyle: .videoFrame(timestamp: Timestamp(currentTime))) {
                    
                    let conversionMatrix:Matrix3x3
                    if (self.supportsFullYUVRange) {
                        conversionMatrix = colorConversionMatrix601FullRangeDefault
                    } else {
                        conversionMatrix = colorConversionMatrix601Default
                    }
                    
                    convertYUVToRGB(pipelineState:self.yuvConversionRenderPipelineState!, lookupTable:self.yuvLookupTable, bufferSize:self.yuvBufferSize,
                                    luminanceTexture:Texture(orientation: self.orientation ?? self.location.imageOrientation(), texture:luminanceTexture),
                                    chrominanceTexture:Texture(orientation: self.orientation ?? self.location.imageOrientation(), texture:chrominanceTexture),
                                    resultTexture:outputTexture, colorConversionMatrix:conversionMatrix)
                    texture = outputTexture
                } else {
                    Log.error("Could not get luminance/chrominance/output texture")
                    texture = nil
                }
            } else {
                var textureRef:CVMetalTexture? = nil
                let _ = CVMetalTextureCacheCreateTextureFromImage(kCFAllocatorDefault, self.videoTextureCache!, cameraFrame, nil, .bgra8Unorm, bufferWidth, bufferHeight, 0, &textureRef)
                if let concreteTexture = textureRef,
                    let cameraTexture = CVMetalTextureGetTexture(concreteTexture) {
                    texture = Texture(orientation: self.orientation ?? self.location.imageOrientation(), texture: cameraTexture, timingStyle: .videoFrame(timestamp: Timestamp(currentTime)))
                } else {
                    Log.error("Could not get bgra texture")
                    texture = nil
                }
            }
            
            if let texture = texture {
                self.updateTargetsWithTexture(texture)
            }
        }
            
        if self.runBenchmark {
            self.numberOfFramesCaptured += 1
            if (self.numberOfFramesCaptured > initialBenchmarkFramesToIgnore) {
                let currentFrameTime = (CFAbsoluteTimeGetCurrent() - startTime)
                self.totalFrameTimeDuringCapture += currentFrameTime
                print("Average frame time : \(1000.0 * self.totalFrameTimeDuringCapture / Double(self.numberOfFramesCaptured - initialBenchmarkFramesToIgnore)) ms")
                print("Current frame time : \(1000.0 * currentFrameTime) ms")
            }
        }

        if self.logFPS {
            if ((CFAbsoluteTimeGetCurrent() - self.lastCheckTime) > 1.0) {
                self.lastCheckTime = CFAbsoluteTimeGetCurrent()
                print("FPS: \(self.framesSinceLastCheck)")
                self.framesSinceLastCheck = 0
            }

            self.framesSinceLastCheck += 1
        }

        self.frameRenderingSemaphore.signal()
    }
    
    public func startCapture() {
        self.numberOfFramesCaptured = 0
        self.totalFrameTimeDuringCapture = 0
        
        if (!captureSession.isRunning) {
            captureSession.startRunning()
        }
    }
    
    public func stopCapture() {
        if (captureSession.isRunning) {
            captureSession.stopRunning()
        }
    }

    public func transmitPreviousImage(to target: ImageConsumer, atIndex: UInt) {
        // Not needed for camera
    }
    
    // MARK: -
    // MARK: Audio processing
    
    public func addAudioInputsAndOutputs() throws {
        guard (self.audioOutput == nil) else { return }
        
        captureSession.beginConfiguration()
        defer {
            captureSession.commitConfiguration()
        }
        guard let microphone = AVCaptureDevice.default(for: .audio) else {
            return
        }
        let audioInput = try AVCaptureDeviceInput(device:microphone)
        if captureSession.canAddInput(audioInput) {
           captureSession.addInput(audioInput)
        }
        let audioOutput = AVCaptureAudioDataOutput()
        if captureSession.canAddOutput(audioOutput) {
            captureSession.addOutput(audioOutput)
        }
        self.microphone = microphone
        self.audioInput = audioInput
        self.audioOutput = audioOutput
        audioOutput.setSampleBufferDelegate(self, queue:cameraAudioProcessingQueue)
    }
    
    public func removeAudioInputsAndOutputs() {
        guard (audioOutput != nil) else { return }
        
        captureSession.beginConfiguration()
        captureSession.removeInput(audioInput!)
        captureSession.removeOutput(audioOutput!)
        audioInput = nil
        audioOutput = nil
        microphone = nil
        captureSession.commitConfiguration()
    }
    
    func processAudioSampleBuffer(_ sampleBuffer:CMSampleBuffer) {
        self.audioEncodingTarget?.processAudioBuffer(sampleBuffer)
    }
}
