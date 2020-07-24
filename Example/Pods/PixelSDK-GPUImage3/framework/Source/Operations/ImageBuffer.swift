import Foundation

public class ImageBuffer: ImageProcessingOperation {
    // TODO: Dynamically release textures on buffer resize
    public var bufferSize:UInt = 1
    public var activatePassthroughOnNextFrame = true
    
    public let maximumInputs:UInt = 1
    public let targets = TargetContainer()
    public let sources = SourceContainer()
    var bufferedTextures = [Texture]()
    
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

    public func newTextureAvailable(_ texture: Texture, fromSourceIndex: UInt) {
        userInfo = texture.userInfo
        
        bufferedTextures.append(texture)
        if (bufferedTextures.count > Int(bufferSize)) {
            let releasedTexture = bufferedTextures.removeFirst()
            updateTargetsWithTexture(releasedTexture)
        } else if activatePassthroughOnNextFrame {
            activatePassthroughOnNextFrame = false
            // Pass along the current frame to keep processing going until the buffer is built up
            updateTargetsWithTexture(texture)
        }
    }
    
    public func transmitPreviousImage(to target:ImageConsumer, atIndex:UInt) {
        // Buffers most likely won't need this
    }
}
