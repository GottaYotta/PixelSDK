#if canImport(UIKit)
import UIKit
#else
import Cocoa
#endif
import MetalKit

public enum PictureInputError: Error, CustomStringConvertible {
    case cgImageNilError
    case noSuchImageError(imageName:String)
    
    public var errorDescription:String {
        switch self {
        case .cgImageNilError:
            return "Unable to retrieve CGImage"
        case .noSuchImageError(let imageName):
            return "No such image named: \(imageName) in your application bundle"
        }
    }
    
    public var description:String {
        return "<\(type(of: self)): errorDescription = \(self.errorDescription)>"
    }
}

public class PictureInput: ImageSource {
    public let targets = TargetContainer()
    var internalTexture:Texture?
    public var textureUserInfo:[AnyHashable:Any]?
    var hasProcessedImage:Bool = false
    var internalImage:CGImage?
    
    let pictureInputProcessingQueue = DispatchQueue(label: "com.sunsetlakesoftware.GPUImage.pictureInputProcessingQueue")
    
    public init(image:CGImage, smoothlyScaleOutput:Bool = false, orientation:ImageOrientation = .portrait) {
        internalImage = image
    }
    
    #if canImport(UIKit)
    public convenience init(image:UIImage, smoothlyScaleOutput:Bool = false, orientation:ImageOrientation = .portrait) throws {
        guard let cgImage = image.cgImage else { throw PictureInputError.cgImageNilError }
        self.init(image: cgImage, smoothlyScaleOutput: smoothlyScaleOutput, orientation: orientation)
    }
    
    public convenience init(imageName:String, smoothlyScaleOutput:Bool = false, orientation:ImageOrientation = .portrait) throws {
        guard let image = UIImage(named:imageName) else { throw PictureInputError.noSuchImageError(imageName:imageName)}
        try self.init(image:image, smoothlyScaleOutput:smoothlyScaleOutput, orientation:orientation)
    }
    #else
    public convenience init(image:NSImage, smoothlyScaleOutput:Bool = false, orientation:ImageOrientation = .portrait) throws {
        guard let cgImage = image.cgImage(forProposedRect:nil, context:nil, hints:nil) else { throw PictureInputError.cgImageNilError }
        self.init(image:cgImage, smoothlyScaleOutput:smoothlyScaleOutput, orientation:orientation)
    }
    
    public convenience init(imageName:String, smoothlyScaleOutput:Bool = false, orientation:ImageOrientation = .portrait) throws {
        let imageName = NSImage.Name(imageName)
        guard let image = NSImage(named:imageName) else { PictureInputError.noSuchImageError(imageName:imageName) }
        self.init(image:image.cgImage(forProposedRect:nil, context:nil, hints:nil)!, smoothlyScaleOutput:smoothlyScaleOutput, orientation:orientation)
    }
    #endif
    
    public func processImage(synchronously:Bool = false) {
        if let texture = internalTexture {
            texture.userInfo = self.textureUserInfo
            if synchronously {
                autoreleasepool {
                    self.updateTargetsWithTexture(texture)
                }
                self.hasProcessedImage = true
            } else {
                self.pictureInputProcessingQueue.async {
                    autoreleasepool {
                        self.updateTargetsWithTexture(texture)
                    }
                    self.hasProcessedImage = true
                }
            }
        } else {
            let textureLoader = MTKTextureLoader(device: sharedMetalRenderingDevice.device)
            if synchronously {
                do {
                    let imageTexture = try textureLoader.newTexture(cgImage:internalImage!, options: [MTKTextureLoader.Option.SRGB : false])
                    internalImage = nil
                    self.internalTexture = Texture(orientation: .portrait, texture: imageTexture)
                    self.internalTexture?.userInfo = self.textureUserInfo
                    self.updateTargetsWithTexture(self.internalTexture!)
                    self.hasProcessedImage = true
                } catch {
                    Log.error("Error loading image texture: \(error)")
                    return
                }
            } else {
                textureLoader.newTexture(cgImage:internalImage!, options: [MTKTextureLoader.Option.SRGB : false], completionHandler: { (possibleTexture, error) in
                    guard (error == nil) else {
                        Log.error("Error loading image texture: \(error!)")
                        return
                    }
                    guard let texture = possibleTexture else {
                        Log.error("Nil texture received")
                        return
                    }
                    self.internalImage = nil
                    self.internalTexture = Texture(orientation: .portrait, texture: texture)
                    self.internalTexture?.userInfo = self.textureUserInfo
                    self.pictureInputProcessingQueue.async {
                        autoreleasepool {
                            self.updateTargetsWithTexture(self.internalTexture!)
                        }
                        self.hasProcessedImage = true
                    }
                })
            }
        }
    }
    
    public func transmitPreviousImage(to target:ImageConsumer, atIndex:UInt) {
        if hasProcessedImage {
            target.newTextureAvailable(self.internalTexture!, fromSourceIndex:atIndex)
        }
    }
}
