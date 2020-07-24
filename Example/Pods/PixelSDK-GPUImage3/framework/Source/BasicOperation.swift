import Foundation
import Metal

public func defaultVertexFunctionNameForInputs(_ inputCount:UInt) -> String {
    switch inputCount {
    case 1:
        return "oneInputVertex"
    case 2:
        return "twoInputVertex"
    default:
        return "oneInputVertex"
    }
}

open class BasicOperation: ImageProcessingOperation {
    
    public let maximumInputs: UInt
    public let targets = TargetContainer()
    public let sources = SourceContainer()
    
    public var activatePassthroughOnNextFrame: Bool = false
    public var uniformSettings:ShaderUniformSettings
    public var useMetalPerformanceShaders: Bool = false {
        didSet {
            if !sharedMetalRenderingDevice.metalPerformanceShadersAreSupported {
                //Log.warning("Metal Performance Shaders are not supported on this device")
                useMetalPerformanceShaders = false
            }
        }
    }

    public let renderPipelineState: MTLRenderPipelineState
    let operationName: String
    public var inputTextures = [UInt:Texture]()
    let textureInputSemaphore = DispatchSemaphore(value:1)
    public var useNormalizedTextureCoordinates = true
    var metalPerformanceShaderPathway: ((MTLCommandBuffer, [UInt:Texture], Texture) -> ())?
    
    public private(set) var userInfo:[AnyHashable:Any]? {
        get {
            _userInfoLock.lock()
            let aUserInfo = _userInfo
            _userInfoLock.unlock()
            return aUserInfo
        }
        set {
            _userInfoLock.lock()
            _userInfo = newValue
            _userInfoLock.unlock()
        }
    }
    var _userInfo:[AnyHashable:Any]?
    var _userInfoLock = NSLock()
    
    public init(vertexFunctionName: String? = nil, fragmentFunctionName: String, numberOfInputs: UInt = 1, operationName: String = #file, shaderLibrary:MTLLibrary? = nil) {
        self.maximumInputs = numberOfInputs
        self.operationName = operationName
        
        let concreteVertexFunctionName = vertexFunctionName ?? defaultVertexFunctionNameForInputs(numberOfInputs)
        let (pipelineState, lookupTable, bufferSize) = generateRenderPipelineState(device:sharedMetalRenderingDevice, vertexFunctionName:concreteVertexFunctionName, fragmentFunctionName:fragmentFunctionName, operationName:operationName, shaderLibrary:shaderLibrary)
        self.renderPipelineState = pipelineState
        self.uniformSettings = ShaderUniformSettings(uniformLookupTable:lookupTable, bufferSize:bufferSize)
    }
    
    public func transmitPreviousImage(to target: ImageConsumer, atIndex: UInt) {
        // TODO: Finish implementation later
    }
    
    open func newTextureAvailable(_ texture: Texture, fromSourceIndex: UInt) {
        let _ = textureInputSemaphore.wait(timeout:DispatchTime.distantFuture)
        defer {
            textureInputSemaphore.signal()
        }
        
        inputTextures[fromSourceIndex] = texture
        
        if (UInt(inputTextures.count) >= maximumInputs) || activatePassthroughOnNextFrame {
            let outputWidth:Int
            let outputHeight:Int
            
            let firstInputTexture = inputTextures[0]!
            if firstInputTexture.orientation.rotationNeeded(for:.portrait).flipsDimensions() {
                outputWidth = firstInputTexture.texture.height
                outputHeight = firstInputTexture.texture.width
            } else {
                outputWidth = firstInputTexture.texture.width
                outputHeight = firstInputTexture.texture.height
            }

            if uniformSettings.usesAspectRatio {
                let outputRotation = firstInputTexture.orientation.rotationNeeded(for:.portrait)
                uniformSettings["aspectRatio"] = firstInputTexture.aspectRatio(for: outputRotation)
            }
            
            guard let commandBuffer = sharedMetalRenderingDevice.commandQueue.makeCommandBuffer() else {
                Log.error("Could not create command buffer")
                return
            }
            
            guard let outputTexture = Texture(device:sharedMetalRenderingDevice.device, orientation: .portrait, width: outputWidth, height: outputHeight, timingStyle: firstInputTexture.timingStyle) else {
                Log.error("Could not create texture of size (\(outputWidth), \(outputHeight)")
                return
            }
            
            var foundUserInfo:[AnyHashable:Any]?
            for (_, texture) in inputTextures {
                // Pick userInfo from whichever input buffer has it
                if let textureUserInfo = texture.userInfo {
                    foundUserInfo = textureUserInfo
                }
            }
            // Pass onto the output texture
            outputTexture.userInfo = foundUserInfo
            userInfo = foundUserInfo
            
            guard (!activatePassthroughOnNextFrame) else { // Use this to allow a bootstrap of cyclical processing, like with a low pass filter
                activatePassthroughOnNextFrame = false
                // TODO: Render rotated passthrough image here
                
                removeTransientInputs()
                textureInputSemaphore.signal()
                updateTargetsWithTexture(outputTexture)
                let _ = textureInputSemaphore.wait(timeout:DispatchTime.distantFuture)

                return
            }
            
            if let alternateRenderingFunction = metalPerformanceShaderPathway, useMetalPerformanceShaders {
                var rotatedInputTextures: [UInt:Texture]
                if (firstInputTexture.orientation.rotationNeeded(for:.portrait) != .noRotation) {
                    guard let rotationOutputTexture = Texture(device:sharedMetalRenderingDevice.device, orientation: .portrait, width: outputWidth, height: outputHeight) else {
                        Log.error("Could not create texture of size: (\(outputWidth), \(outputHeight)")
                        return
                    }
                    guard let rotationCommandBuffer = sharedMetalRenderingDevice.commandQueue.makeCommandBuffer() else {
                        Log.error("Could not create command buffer")
                        return
                    }
                    rotationCommandBuffer.renderQuad(pipelineState: sharedMetalRenderingDevice.passthroughRenderState, uniformSettings: uniformSettings, inputTextures: inputTextures, useNormalizedTextureCoordinates: useNormalizedTextureCoordinates, outputTexture: rotationOutputTexture)
                    rotationCommandBuffer.commit()
                    rotatedInputTextures = inputTextures
                    rotatedInputTextures[0] = rotationOutputTexture
                } else {
                    rotatedInputTextures = inputTextures
                }
                alternateRenderingFunction(commandBuffer, rotatedInputTextures, outputTexture)
            } else {
                internalRenderFunction(commandBuffer: commandBuffer, outputTexture: outputTexture)
            }
            commandBuffer.commit()
            
            removeTransientInputs()
            textureInputSemaphore.signal()
            updateTargetsWithTexture(outputTexture)
            let _ = textureInputSemaphore.wait(timeout:DispatchTime.distantFuture)
        }
    }
    
    func removeTransientInputs() {
        for index in 0..<self.maximumInputs {
            if let texture = inputTextures[index], texture.timingStyle.isTransient() {
                inputTextures[index] = nil
            }
        }
    }
    
    open func internalRenderFunction(commandBuffer: MTLCommandBuffer, outputTexture: Texture) {
        commandBuffer.renderQuad(pipelineState: renderPipelineState, uniformSettings: uniformSettings, inputTextures: inputTextures, useNormalizedTextureCoordinates: useNormalizedTextureCoordinates, outputTexture: outputTexture)
    }
}
