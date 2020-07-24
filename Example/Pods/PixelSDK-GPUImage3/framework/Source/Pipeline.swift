// MARK: -
// MARK: Basic types
import Foundation

fileprivate let pipelineProcessingQueue = DispatchQueue(label:"com.sunsetlakesoftware.GPUImage.pipelineProcessingQueue")

public protocol ImageSource {
    var targets:TargetContainer { get }
    func transmitPreviousImage(to target:ImageConsumer, atIndex:UInt)
}

public protocol ImageConsumer:AnyObject {
    var maximumInputs:UInt { get }
    var sources:SourceContainer { get }
    
    func newTextureAvailable(_ texture:Texture, fromSourceIndex:UInt)
}

public protocol ImageProcessingOperation: ImageConsumer, ImageSource {
    // The userInfo of the texture last received by the ImageProcessingOperation
    var userInfo:[AnyHashable:Any]? { get }
}

infix operator --> : AdditionPrecedence
//precedencegroup ProcessingOperationPrecedence {
//    associativity: left
////    higherThan: Multiplicative
//}
@discardableResult public func --><T:ImageConsumer>(source:ImageSource, destination:T) -> T {
    source.addTarget(destination)
    return destination
}

// MARK: -
// MARK: Extensions and supporting types

public extension ImageSource {
    func addTarget(_ target:ImageConsumer, atTargetIndex:UInt? = nil) {
        pipelineProcessingQueue.async {
            if let targetIndex = atTargetIndex {
                target.setSource(self, atIndex:targetIndex)
                self.targets.append(target, indexAtTarget:targetIndex)
                //transmitPreviousImage(to:target, atIndex:targetIndex)
            } else if let indexAtTarget = target.addSource(self) {
                self.targets.append(target, indexAtTarget:indexAtTarget)
                //transmitPreviousImage(to:target, atIndex:indexAtTarget)
            } else {
                Log.warning("Tried to add target beyond target's input capacity")
            }
        }
    }

    func removeAllTargets() {
        pipelineProcessingQueue.async {
            for (target, index) in self.targets.targets {
                target.removeSourceAtIndex(index)
            }
            self.targets.removeAll()
        }
    }
    
    func remove(_ target:ImageConsumer) {
        pipelineProcessingQueue.async {
            for (testTarget, index) in self.targets.targets {
                if(target === testTarget) {
                    target.removeSourceAtIndex(index)
                    self.targets.remove(target)
                }
            }
        }
    }
    
    func updateTargetsWithTexture(_ texture:Texture) {
        var targets = [(ImageConsumer, UInt)]()
        
        pipelineProcessingQueue.sync {
            targets = self.targets.targets
        }
        
        for (target, index) in targets {
            target.newTextureAvailable(texture, fromSourceIndex:index)
        }
    }
}

public extension ImageConsumer {
    fileprivate func addSource(_ source:ImageSource) -> UInt? {
        return sources.append(source, maximumInputs:maximumInputs)
    }
    
    fileprivate func setSource(_ source:ImageSource, atIndex:UInt) {
        _ = sources.insert(source, atIndex:atIndex, maximumInputs:maximumInputs)
    }

    fileprivate func removeSourceAtIndex(_ index:UInt) {
        sources.removeAtIndex(index)
    }
    
    func removeAllSources() {
        pipelineProcessingQueue.async {
            for (index, source) in self.sources.sources {
                self.removeSourceAtIndex(index)
                source.targets.remove(self)
            }
        }
    }
}

class WeakImageConsumer {
    weak var value:ImageConsumer?
    let indexAtTarget:UInt
    init (value:ImageConsumer, indexAtTarget:UInt) {
        self.indexAtTarget = indexAtTarget
        self.value = value
    }
}

public class TargetContainer {
    fileprivate var weakTargets = [WeakImageConsumer]()
    
    fileprivate var targets: [(ImageConsumer, UInt)] {
        // Get list of values that have not deallocated
        let targets: [(ImageConsumer, UInt)] = self.weakTargets.compactMap { weakImageConsumer in
            if let imageConsumer = weakImageConsumer.value {
                return (imageConsumer, weakImageConsumer.indexAtTarget)
            }
            else {
                return nil
            }
        }
        
        // Remove any deallocated values
        self.weakTargets = self.weakTargets.filter { $0.value != nil }
        
        return targets
    }
    
    public init() {
    }
    
    fileprivate func append(_ target:ImageConsumer, indexAtTarget:UInt) {
        // TODO: Don't allow the addition of a target more than once
        self.weakTargets.append(WeakImageConsumer(value:target, indexAtTarget:indexAtTarget))
    }
    
    fileprivate func removeAll() {
        self.weakTargets.removeAll()
    }
    
    fileprivate func remove(_ target:ImageConsumer) {
        self.weakTargets = self.weakTargets.filter { $0.value !== target }
    }
}

public class SourceContainer {
    fileprivate var sources:[UInt:ImageSource] = [:]
    
    public init() {
    }
    
    fileprivate func append(_ source:ImageSource, maximumInputs:UInt) -> UInt? {
        var currentIndex:UInt = 0
        while currentIndex < maximumInputs {
            if (sources[currentIndex] == nil) {
                sources[currentIndex] = source
                return currentIndex
            }
            currentIndex += 1
        }
        
        return nil
    }
    
    fileprivate func insert(_ source:ImageSource, atIndex:UInt, maximumInputs:UInt) -> UInt {
        guard (atIndex < maximumInputs) else { fatalError("ERROR: Attempted to set a source beyond the maximum number of inputs on this operation") }
        sources[atIndex] = source
        return atIndex
    }
    
    fileprivate func removeAtIndex(_ index:UInt) {
        sources[index] = nil
    }
}

public class ImageRelay: ImageProcessingOperation {
    public var newImageCallback:((Texture) -> ())?
    
    public let sources = SourceContainer()
    public let targets = TargetContainer()
    public let maximumInputs:UInt = 1
    public var preventRelay:Bool = false
    
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
    
    public func transmitPreviousImage(to target:ImageConsumer, atIndex:UInt) {
        var source: ImageSource?
        
        pipelineProcessingQueue.sync {
            source = sources.sources[0]
        }
        
        source?.transmitPreviousImage(to:self, atIndex:0)
    }

    public func newTextureAvailable(_ texture: Texture, fromSourceIndex: UInt) {
        userInfo = texture.userInfo
        
        if let newImageCallback = newImageCallback {
            newImageCallback(texture)
        }
        if (!preventRelay) {
            relayTextureOnward(texture)
        }
    }
    
    public func relayTextureOnward(_ texture:Texture) {
        var targets = [(ImageConsumer, UInt)]()
        
        pipelineProcessingQueue.sync {
            targets = self.targets.targets
        }
        
        for (target, index) in targets {
            target.newTextureAvailable(texture, fromSourceIndex:index)
        }
    }
}
