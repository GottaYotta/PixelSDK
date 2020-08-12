import Foundation
import Metal
import MetalPerformanceShaders

public let sharedMetalRenderingDevice = MetalRenderingDevice()

public class MetalRenderingDevice {
    // MTLDevice
    // MTLCommandQueue
    
    public let device: MTLDevice
    public let commandQueue: MTLCommandQueue
    public let shaderLibrary: MTLLibrary
    public let metalPerformanceShadersAreSupported: Bool
    
    lazy var passthroughRenderState: MTLRenderPipelineState = {
        let (pipelineState, _, _) = generateRenderPipelineState(device:self, vertexFunctionName:"oneInputVertex", fragmentFunctionName:"passthroughFragment", operationName:"Passthrough")
        return pipelineState
    }()

    lazy var colorSwizzleRenderState: MTLRenderPipelineState = {
        let (pipelineState, _, _) = generateRenderPipelineState(device:self, vertexFunctionName:"oneInputVertex", fragmentFunctionName:"colorSwizzleFragment", operationName:"ColorSwizzle")
        return pipelineState
    }()

    init() {
        guard let device = MTLCreateSystemDefaultDevice() else {fatalError("Could not create Metal Device. Metal is supported on iOS 11+ physical devices and iOS 13+ simulators.")}
        self.device = device
        
        guard let queue = self.device.makeCommandQueue() else {fatalError("Could not create command queue")}
        self.commandQueue = queue
        
        
        #if targetEnvironment(simulator)
        self.metalPerformanceShadersAreSupported = false
        #else
        if #available(iOS 9, macOS 10.13, *) {
            self.metalPerformanceShadersAreSupported = MPSSupportsMTLDevice(device)
        } else {
            self.metalPerformanceShadersAreSupported = false
        }
        #endif
        do {
            let frameworkBundle = Bundle(for: MetalRenderingDevice.self)
            let metalLibraryPath = frameworkBundle.path(forResource: "default", ofType: "metallib")!
            
            self.shaderLibrary = try device.makeLibrary(filepath:metalLibraryPath)
        } catch {
            fatalError("Could not load library")
        }
    }
}
