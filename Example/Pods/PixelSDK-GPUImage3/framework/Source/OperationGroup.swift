import Foundation

open class OperationGroup: ImageProcessingOperation {
    let inputImageRelay = ImageRelay()
    let outputImageRelay = ImageRelay()
    
    public var sources:SourceContainer { get { return inputImageRelay.sources } }
    public var targets:TargetContainer { get { return outputImageRelay.targets } }
    public let maximumInputs:UInt = 1
    
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
    
    public init() {
    }
    
    public func newTextureAvailable(_ texture:Texture, fromSourceIndex:UInt) {
        userInfo = texture.userInfo
        
        inputImageRelay.newTextureAvailable(texture, fromSourceIndex:fromSourceIndex)
    }
    
    public func configureGroup(_ configurationOperation:(_ input:ImageRelay, _ output:ImageRelay) -> ()) {
        configurationOperation(inputImageRelay, outputImageRelay)
    }
    
    public func transmitPreviousImage(to target:ImageConsumer, atIndex:UInt) {
        outputImageRelay.transmitPreviousImage(to:target, atIndex:atIndex)
    }
}
