public class Sharpen: BasicOperation {
    public var sharpness:Float = 0.0 { didSet { uniformSettings["sharpness"] = sharpness } }
    public var overriddenTexelSize:Size?
    
    public init() {
        super.init(vertexFunctionName: "sharpenVertex", fragmentFunctionName: "sharpenFragment", numberOfInputs: 1)
        
        ({sharpness = 0.0})()
    }
    
    public override func newTextureAvailable(_ texture: Texture, fromSourceIndex: UInt) {
        let outputRotation = texture.orientation.rotationNeeded(for:.portrait)
        let texelSize = overriddenTexelSize ?? texture.texelSize(for:outputRotation)
        uniformSettings["texelWidth"] = texelSize.width
        uniformSettings["texelHeight"] = texelSize.height
        
        super.newTextureAvailable(texture, fromSourceIndex: fromSourceIndex)
    }
}
