import Foundation
import MetalKit

// These delegate calls may be called by any thread
public protocol RenderViewDelegate: class {
    func willDisplayTexture(renderView: RenderView, texture: Texture)
    func didDisplayTexture(renderView: RenderView, texture: Texture)
}

public class RenderView: UIView, ImageConsumer {
    public weak var renderViewDelegate:RenderViewDelegate?
    
    public let sources = SourceContainer()
    public let maximumInputs: UInt = 1
    var currentTexture: Texture?
    var renderPipelineState:MTLRenderPipelineState!
    
    // Separate var so we can access from place other than main thread
    unowned var internalLayer: CALayer!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        self.internalLayer = self.layer
        
        #if targetEnvironment(simulator)
        if #available(iOS 13.0, *) {
            let layer = self.internalLayer as! CAMetalLayer
            layer.framebufferOnly = false
            layer.device = sharedMetalRenderingDevice.device
        }
        #else
        let layer = self.internalLayer as! CAMetalLayer
        layer.framebufferOnly = false
        layer.device = sharedMetalRenderingDevice.device
        #endif
        
        let (pipelineState, _, _) = generateRenderPipelineState(device:sharedMetalRenderingDevice, vertexFunctionName:"oneInputVertex", fragmentFunctionName:"passthroughFragment", operationName:"RenderView")
        self.renderPipelineState = pipelineState
    }
    
    // We use CAMetalLayer instead of MTKView because on iOS 11 we were getting the following crash when moving videos around in the cropper: [CAMetalLayerDrawable texture] should not be called after already presenting this drawable. Get a nextDrawable instead.
    // This was likely a bug in iOS https://developer.apple.com/forums/thread/64889
    // We should be using the CAMetalLayer anyways because we don't need the added functionality of MTKView.
    // MTKView also wouldn't work correctly in simulator unless autoresizeDrawable was set to true which was odd.
    // Unfortunately we have to jump through a lot of hoops because CAMetalLayer is only available in iOS 13 simulator but all iOS versions for devices.
    public override class var layerClass : AnyClass {
        #if targetEnvironment(simulator)
        if #available(iOS 13.0, *) {
            return CAMetalLayer.self
        } else {
            return CALayer.self
        }
        #else
        return CAMetalLayer.self
        #endif
    }
    
    public func newTextureAvailable(_ texture:Texture, fromSourceIndex:UInt) {
        #if targetEnvironment(simulator)
        if #available(iOS 13.0, *) {
            let layer = self.internalLayer as! CAMetalLayer
            layer.drawableSize = CGSize(width: texture.texture.width, height: texture.texture.height)
        }
        #else
        let layer = self.internalLayer as! CAMetalLayer
        layer.drawableSize = CGSize(width: texture.texture.width, height: texture.texture.height)
        #endif
        self.currentTexture = texture
        self.render()
    }
    
    public override func draw(_ rect: CGRect) {
        self.render()
    }
    
    public override func draw(_ layer: CALayer, in ctx: CGContext) {
        self.render()
    }
    
    func render() {
        // Necessary according to https://developer.apple.com/documentation/quartzcore/cametallayer
        // Without this we were getting a deadlock when setting drawableSize
        autoreleasepool {
            #if targetEnvironment(simulator)
            if #available(iOS 13.0, *) {
                let layer = self.internalLayer as! CAMetalLayer
                guard let nextDrawable = layer.nextDrawable() else {
                    Log.warning("Could not retrieve next drawable")
                    return
                }
                renderInternal(nextDrawable: nextDrawable)
            }
            #else
            let layer = self.internalLayer as! CAMetalLayer
            guard let nextDrawable = layer.nextDrawable() else {
                Log.warning("Could not retrieve next drawable")
                return
            }
            renderInternal(nextDrawable: nextDrawable)
            #endif
        }
    }
    
    func renderInternal(nextDrawable: CAMetalDrawable) {
        guard let commandBuffer = sharedMetalRenderingDevice.commandQueue.makeCommandBuffer() else {
            Log.warning("Could not make command buffer")
            return
        }
        
        guard let currentTexture = self.currentTexture else {
            Log.warning("Could not retrieve current texture")
            return
        }
        
        self.renderViewDelegate?.willDisplayTexture(renderView: self, texture: currentTexture)
        
        let outputTexture = Texture(orientation: .portrait, texture: nextDrawable.texture)
        commandBuffer.renderQuad(pipelineState: renderPipelineState, inputTextures: [0:currentTexture], outputTexture: outputTexture)
        
        commandBuffer.present(nextDrawable)
        commandBuffer.addCompletedHandler({ (commandBuffer) in
            self.renderViewDelegate?.didDisplayTexture(renderView: self, texture: currentTexture)
        })
        commandBuffer.commit()
    }
}


