// swift-interface-format-version: 1.0
// swift-compiler-version: Apple Swift version 5.2.4 (swiftlang-1103.0.32.9 clang-1103.0.32.53)
// swift-module-flags: -target arm64-apple-ios11.0 -enable-objc-interop -enable-library-evolution -swift-version 5 -enforce-exclusivity=checked -O -module-name PixelSDK
import AVFoundation
import CommonCrypto
import CoreLocation
import CoreMotion
import Foundation
import GPUImage
import MediaPlayer
import MobileCoreServices
import Photos
import PhotosUI
@_exported import PixelSDK
import Swift
import UIKit
@_inheritsConvenienceInitializers open class SessionFilterToon : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterGaussianBlur : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterSepiaTone : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterSepulveda : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterMontana : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterStretchDistortion : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@objc @_inheritsConvenienceInitializers @objcMembers public class SessionManager : ObjectiveC.NSObject {
  @objc public static let shared: PixelSDK.SessionManager
  @objc public var savedSessions: [PixelSDK.Session] {
    get
  }
  @objc public var didRestoreSavedSessions: Swift.Bool {
    get
  }
  @objc public static let DidRestoreSavedSessionsNotification: Foundation.Notification.Name
  @objc deinit
  @objc override dynamic public init()
}
@_inheritsConvenienceInitializers open class SessionFilterCannyEdgeDetection : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterSwirl : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@objc public protocol EditControllerDelegate : AnyObject {
  @objc optional func editController(_ editController: PixelSDK.EditController, didLoadEditing session: PixelSDK.Session)
  @objc optional func editController(_ editController: PixelSDK.EditController, willBeginEditing session: PixelSDK.Session)
  @objc optional func editController(_ editController: PixelSDK.EditController, didBeginEditing session: PixelSDK.Session)
  @objc func editController(_ editController: PixelSDK.EditController, didFinishEditing session: PixelSDK.Session)
  @objc optional func editController(_ editController: PixelSDK.EditController, didCancelEditing session: PixelSDK.Session?)
}
public enum EditMode : Swift.Equatable {
  case filter
  case trim
  case adjust
  case custom(title: Swift.String, controller: UIKit.UIViewController)
  public static func == (lhs: PixelSDK.EditMode, rhs: PixelSDK.EditMode) -> Swift.Bool
}
@objc @_hasMissingDesignatedInitializers @objcMembers public class EditController : UIKit.UIViewController {
  @objc convenience public init(session: PixelSDK.Session)
  @objc deinit
  @objc final public let session: PixelSDK.Session
  public var modes: [PixelSDK.EditMode] {
    get
    set
  }
  public var currentMode: PixelSDK.EditMode {
    get
  }
  @objc weak public var delegate: PixelSDK.EditControllerDelegate? {
    @objc get
    @objc set
  }
  @objc @IBOutlet public var backButton: UIKit.UIButton! {
    get
  }
  @objc @IBOutlet public var nextButton: UIKit.UIButton! {
    get
  }
  @objc public var showsSaveDialogue: Swift.Bool
  @objc public var showsPositionAdjustment: Swift.Bool
  @objc public var compactControls: Swift.Bool {
    @objc get
    @objc set
  }
  @objc override dynamic public func viewDidLoad()
  @objc override dynamic public func viewDidLayoutSubviews()
  @objc override dynamic public func viewWillAppear(_ animated: Swift.Bool)
  @objc override dynamic public func viewDidAppear(_ animated: Swift.Bool)
  @objc override dynamic public func viewWillDisappear(_ animated: Swift.Bool)
  @objc override dynamic public func viewDidDisappear(_ animated: Swift.Bool)
  @objc override dynamic public func viewWillTransition(to size: CoreGraphics.CGSize, with coordinator: UIKit.UIViewControllerTransitionCoordinator)
  @objc override dynamic public func willTransition(to newCollection: UIKit.UITraitCollection, with coordinator: UIKit.UIViewControllerTransitionCoordinator)
  @objc override dynamic public var supportedInterfaceOrientations: UIKit.UIInterfaceOrientationMask {
    @objc get
  }
  @objc override dynamic public var prefersStatusBarHidden: Swift.Bool {
    @objc get
  }
  @objc override dynamic public var preferredStatusBarStyle: UIKit.UIStatusBarStyle {
    @objc get
  }
  @objc override dynamic public init(nibName nibNameOrNil: Swift.String?, bundle nibBundleOrNil: Foundation.Bundle?)
}
extension EditController : PixelSDK.TopBarProvider {
  @objc dynamic public var preferredTopBarView: UIKit.UIView? {
    @objc get
  }
  @objc dynamic public func setNeedsTopBarAppearanceUpdate()
}
extension EditController : PixelSDK.BottomBarProvider {
  @objc dynamic public var prefersBottomBarHidden: Swift.Bool {
    @objc get
  }
  @objc dynamic public var preferredBottomBarView: UIKit.UIView? {
    @objc get
  }
  public var preferredBottomBarUpdateAnimation: PixelSDK.BottomBarAnimation {
    get
  }
  @objc dynamic public func setNeedsBottomBarAppearanceUpdate()
}
@_inheritsConvenienceInitializers open class SessionFilterStraighten : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterBulge : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterHighlights : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterPixellate : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterSketch : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
extension CLLocation : Swift.Encodable {
  public func encode(to encoder: Swift.Encoder) throws
}
@_inheritsConvenienceInitializers open class SessionFilterVibrance : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterFalseColor : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterBrightness : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
public enum VideoExporterError : Swift.Error, Swift.CustomStringConvertible {
  case cancelled
  case watermarked
  case backgroundState
  case destroyed
  case internalError(Swift.Error)
  public var errorDescription: Swift.String {
    get
  }
  public var description: Swift.String {
    get
  }
}
@_hasMissingDesignatedInitializers @objcMembers public class VideoExporter {
  public static let shared: PixelSDK.VideoExporter
  @objc public var isExporting: Swift.Bool {
    @objc get
  }
  public func export(video: PixelSDK.SessionVideo, fileType: AVFoundation.AVFileType = .mp4, videoEncodingSettings: [Swift.String : Any]? = nil, audioEncodingSettings: [Swift.String : Any]? = nil, progress: ((Swift.Double) -> Swift.Void)? = nil, completion: @escaping (PixelSDK.VideoExporterError?) -> Swift.Void)
  public func export(videos: [PixelSDK.SessionVideo], fileType: AVFoundation.AVFileType = .mp4, videoEncodingSettings: [Swift.String : Any]? = nil, audioEncodingSettings: [Swift.String : Any]? = nil, progress: ((Swift.Double) -> Swift.Void)? = nil, completion: @escaping (PixelSDK.VideoExporterError?) -> Swift.Void)
  public func export(segment: PixelSDK.SessionVideoSegment, fileType: AVFoundation.AVFileType = .mp4, videoEncodingSettings: [Swift.String : Any]? = nil, audioEncodingSettings: [Swift.String : Any]? = nil, progress: ((Swift.Double) -> Swift.Void)? = nil, completion: @escaping (PixelSDK.VideoExporterError?) -> Swift.Void)
  public func export(segments: [PixelSDK.SessionVideoSegment], fileType: AVFoundation.AVFileType = .mp4, videoEncodingSettings: [Swift.String : Any]? = nil, audioEncodingSettings: [Swift.String : Any]? = nil, progress: ((Swift.Double) -> Swift.Void)? = nil, completion: @escaping (PixelSDK.VideoExporterError?) -> Swift.Void)
  @objc public func cancelExport(completion: (() -> Swift.Void)? = nil)
  @objc deinit
}
@objc public protocol ContainerControllerDelegate : AnyObject {
  @objc optional func containerControllerDidChangeMode(_ containerController: PixelSDK.ContainerController)
  @objc optional func containerControllerDidCancel(_ containerController: PixelSDK.ContainerController)
  @objc optional func containerController(_ containerController: PixelSDK.ContainerController, willShowEditController editController: PixelSDK.EditController, withSession session: PixelSDK.Session)
}
public enum ContainerMode : Swift.Equatable {
  case video
  case photo
  case library
  case custom(title: Swift.String, controller: UIKit.UIViewController)
  public static func == (lhs: PixelSDK.ContainerMode, rhs: PixelSDK.ContainerMode) -> Swift.Bool
}
@objc @_hasMissingDesignatedInitializers @objcMembers public class ContainerController : UIKit.UIViewController {
  @objc convenience dynamic public init()
  convenience public init(mode: PixelSDK.ContainerMode)
  convenience public init(modes: [PixelSDK.ContainerMode])
  public init(modes: [PixelSDK.ContainerMode], initialMode: PixelSDK.ContainerMode, restoresPreviousMode: Swift.Bool = true)
  public var modes: [PixelSDK.ContainerMode] {
    get
  }
  public var currentMode: PixelSDK.ContainerMode {
    get
  }
  @objc weak public var delegate: PixelSDK.ContainerControllerDelegate?
  @objc weak public var editControllerDelegate: PixelSDK.EditControllerDelegate?
  @objc public var cameraController: PixelSDK.CameraController {
    @objc get
  }
  @objc public var libraryController: PixelSDK.LibraryController {
    @objc get
  }
  @objc override dynamic public func viewDidLoad()
  @objc override dynamic public func viewWillAppear(_ animated: Swift.Bool)
  @objc override dynamic public func viewWillDisappear(_ animated: Swift.Bool)
  @objc override dynamic public func viewWillTransition(to size: CoreGraphics.CGSize, with coordinator: UIKit.UIViewControllerTransitionCoordinator)
  @objc override dynamic public func willTransition(to newCollection: UIKit.UITraitCollection, with coordinator: UIKit.UIViewControllerTransitionCoordinator)
  @objc override dynamic public var supportedInterfaceOrientations: UIKit.UIInterfaceOrientationMask {
    @objc get
  }
  @objc override dynamic public var childForStatusBarStyle: UIKit.UIViewController? {
    @objc get
  }
  @objc override dynamic public var prefersStatusBarHidden: Swift.Bool {
    @objc get
  }
  @objc deinit
  @objc override dynamic public init(nibName nibNameOrNil: Swift.String?, bundle nibBundleOrNil: Foundation.Bundle?)
}
extension ContainerController : PixelSDK.BottomBarProvider {
  @objc dynamic public var prefersBottomBarHidden: Swift.Bool {
    @objc get
  }
  @objc dynamic public var preferredBottomBarView: UIKit.UIView? {
    @objc get
  }
  public var preferredBottomBarUpdateAnimation: PixelSDK.BottomBarAnimation {
    get
  }
  @objc dynamic public func setNeedsBottomBarAppearanceUpdate()
}
extension UIColor : Swift.Encodable {
  public func encode(to encoder: Swift.Encoder) throws
}
public enum BottomBarAnimation {
  case slide
  case none
  public static func == (a: PixelSDK.BottomBarAnimation, b: PixelSDK.BottomBarAnimation) -> Swift.Bool
  public var hashValue: Swift.Int {
    get
  }
  public func hash(into hasher: inout Swift.Hasher)
}
public protocol BottomBarProvider {
  var prefersBottomBarHidden: Swift.Bool { get }
  var preferredBottomBarView: UIKit.UIView? { get }
  var preferredBottomBarUpdateAnimation: PixelSDK.BottomBarAnimation { get }
  func setNeedsBottomBarAppearanceUpdate()
}
extension BottomBarProvider {
  public var prefersBottomBarHidden: Swift.Bool {
    get
  }
  public var preferredBottomBarView: UIKit.UIView? {
    get
  }
  public var preferredBottomBarUpdateAnimation: PixelSDK.BottomBarAnimation {
    get
  }
}
extension BottomBarProvider where Self : UIKit.UIViewController {
  public func setNeedsBottomBarAppearanceUpdate()
}
@_inheritsConvenienceInitializers open class SessionFilterCGAColorspace : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@objc @_hasMissingDesignatedInitializers @objcMembers public class SessionImage : ObjectiveC.NSObject, Swift.Codable {
  @objc public var naturalSize: CoreGraphics.CGSize {
    get
  }
  @objc public var actualSize: CoreGraphics.CGSize {
    @objc get
  }
  @objc public var renderSize: CoreGraphics.CGSize {
    @objc get
  }
  @objc public var preferredTransform: CoreGraphics.CGAffineTransform {
    @objc get
    @objc set
  }
  public var cropRect: CoreGraphics.CGRect? {
    get
    set
  }
  public var primaryFilter: PixelSDK.SessionFilter? {
    get
    set
  }
  public var filters: [PixelSDK.SessionFilter] {
    get
    set
  }
  @objc public var location: CoreLocation.CLLocation?
  public var latitude: Swift.Double? {
    get
  }
  public var longitude: Swift.Double? {
    get
  }
  @objc public var exportedImageURL: Foundation.URL {
    @objc get
  }
  @objc public var dateExported: Foundation.Date? {
    get
  }
  @objc public var isExported: Swift.Bool {
    @objc get
  }
  required public init(from decoder: Swift.Decoder) throws
  public func encode(to encoder: Swift.Encoder) throws
  @objc deinit
  public func requestThumbnail(boundingSize: CoreGraphics.CGSize, contentMode: PixelSDK.ContentMode, filter: PixelSDK.SessionFilter? = nil, completion: @escaping ((UIKit.UIImage?) -> Swift.Void))
  @objc public func invalidateThumbnails()
  @objc override dynamic public init()
}
@_inheritsConvenienceInitializers open class SessionFilterPinch : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_hasMissingDesignatedInitializers @objcMembers public class PixelSDK {
  public static let shared: PixelSDK.PixelSDK
  @objc public static var bundle: Foundation.Bundle {
    @objc get
  }
  @objc public class func setup(_ apiKey: Swift.String)
  public var primaryFilters: [PixelSDK.SessionFilter]
  public var adjustmentFilters: [PixelSDK.SessionFilter]
  public static let defaultInstaFilters: [PixelSDK.SessionFilter]
  public static let defaultVisualEffectFilters: [PixelSDK.SessionFilter]
  @objc public var apiKey: Swift.String? {
    @objc get
  }
  @objc public var maxVideoDuration: Swift.Int
  @available(*, deprecated, renamed: "primaryFilters")
  public var availablePrimaryFilters: () -> [PixelSDK.SessionFilter] {
    get
    set
  }
  @available(*, deprecated, renamed: "adjustmentFilters")
  public var availableAdjustFilters: () -> [PixelSDK.SessionFilter] {
    get
    set
  }
  @available(*, deprecated, renamed: "defaultInstaFilters")
  public static var instaFilters: () -> [PixelSDK.SessionFilter] {
    get
  }
  @available(*, deprecated, renamed: "defaultVisualEffectFilters")
  public static var visualEffectFilters: () -> [PixelSDK.SessionFilter] {
    get
  }
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterVignette : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc public var color: UIKit.UIColor {
    @objc get
    @objc set
  }
  @objc public var center: CoreGraphics.CGPoint {
    @objc get
    @objc set
  }
  @objc public var start: Swift.Double {
    @objc get
    @objc set
  }
  @objc public var end: Swift.Double {
    @objc get
    @objc set
  }
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterSharpness : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterShadows : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterNobleCornerDetection : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterTiltShift : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterSunset : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
extension CGFloat {
  public func translateFromRangeToRange(oldMin: CoreGraphics.CGFloat, oldMax: CoreGraphics.CGFloat, newMin: CoreGraphics.CGFloat, newMax: CoreGraphics.CGFloat) -> CoreGraphics.CGFloat
}
extension Double {
  public func translateFromRangeToRange(oldMin: Swift.Double, oldMax: Swift.Double, newMin: Swift.Double, newMax: Swift.Double) -> Swift.Double
}
extension Float {
  public func translateFromRangeToRange(oldMin: Swift.Float, oldMax: Swift.Float, newMin: Swift.Float, newMax: Swift.Float) -> Swift.Float
}
public protocol TopBarProvider {
  var preferredTopBarView: UIKit.UIView? { get }
  func setNeedsTopBarAppearanceUpdate()
}
extension TopBarProvider {
  public var preferredTopBarView: UIKit.UIView? {
    get
  }
}
extension TopBarProvider where Self : UIKit.UIViewController {
  public func setNeedsTopBarAppearanceUpdate()
}
@_inheritsConvenienceInitializers open class SessionFilterExposure : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@objc public protocol LibraryControllerDelegate : AnyObject {
  @objc optional func libraryControllerDidCancel(_ libraryController: PixelSDK.LibraryController)
  @objc optional func libraryController(_ libraryController: PixelSDK.LibraryController, didFinishWithSession session: PixelSDK.Session, withSegment segment: PixelSDK.SessionVideoSegment?)
  @objc optional func libraryController(_ libraryController: PixelSDK.LibraryController, willShowEditController editController: PixelSDK.EditController, withSession session: PixelSDK.Session)
}
@objc @_hasMissingDesignatedInitializers @objcMembers public class LibraryController : UIKit.UIViewController {
  @objc weak public var delegate: PixelSDK.LibraryControllerDelegate?
  @objc public var showsEditControllerWhenDone: Swift.Bool
  @objc public var fetchPredicate: Foundation.NSPredicate?
  public var draftMediaTypes: [PixelSDK.MediaType] {
    get
    set
  }
  @objc public var splitVideoDraftsIntoSegments: Swift.Bool {
    @objc get
    @objc set
  }
  @objc @IBOutlet public var cancelButton: UIKit.UIButton! {
    get
  }
  @objc @IBOutlet public var nextButton: UIKit.UIButton! {
    get
  }
  @objc @IBOutlet public var activityIndicatorView: UIKit.UIActivityIndicatorView! {
    get
  }
  @objc final public let previewCropController: PixelSDK.PreviewCropController
  @objc override dynamic public func viewDidLoad()
  @objc override dynamic public func viewWillLayoutSubviews()
  @objc override dynamic public func viewWillAppear(_ animated: Swift.Bool)
  @objc override dynamic public func viewDidAppear(_ animated: Swift.Bool)
  @objc override dynamic public func viewWillDisappear(_ animated: Swift.Bool)
  @objc override dynamic public func viewWillTransition(to size: CoreGraphics.CGSize, with coordinator: UIKit.UIViewControllerTransitionCoordinator)
  @objc override dynamic public func willTransition(to newCollection: UIKit.UITraitCollection, with coordinator: UIKit.UIViewControllerTransitionCoordinator)
  @objc override dynamic public var preferredStatusBarStyle: UIKit.UIStatusBarStyle {
    @objc get
  }
  @objc override dynamic public init(nibName nibNameOrNil: Swift.String?, bundle nibBundleOrNil: Foundation.Bundle?)
  @objc deinit
}
extension LibraryController : UIKit.UIGestureRecognizerDelegate {
  @objc dynamic public func gestureRecognizer(_ gestureRecognizer: UIKit.UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIKit.UIGestureRecognizer) -> Swift.Bool
}
extension LibraryController : PixelSDK.BottomBarProvider {
  @objc dynamic public var prefersBottomBarHidden: Swift.Bool {
    @objc get
  }
}
@_inheritsConvenienceInitializers open class SessionFilterMelrose : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
public enum Model : Swift.String {
  case simulator, iPod1, iPod2, iPod3, iPod4, iPod5, iPad2, iPad3, iPad4, iPadAir, iPadAir2, iPadAir3, iPad5, iPad6, iPad7, iPadMini, iPadMini2, iPadMini3, iPadMini4, iPadMini5, iPadPro9_7, iPadPro10_5, iPadPro11, iPadPro12_9, iPadPro2_12_9, iPadPro3_12_9, iPhone4, iPhone4S, iPhone5, iPhone5S, iPhone5C, iPhone6, iPhone6Plus, iPhone6S, iPhone6SPlus, iPhoneSE, iPhone7, iPhone7Plus, iPhone8, iPhone8Plus, iPhoneX, iPhoneXS, iPhoneXSMax, iPhoneXR, iPhone11, iPhone11Pro, iPhone11ProMax, iPhoneSE2, AppleTV, AppleTV_4K, unrecognized
  public typealias RawValue = Swift.String
  public init?(rawValue: Swift.String)
  public var rawValue: Swift.String {
    get
  }
}
extension UIDevice {
  public var type: PixelSDK.Model {
    get
  }
}
@_inheritsConvenienceInitializers open class SessionFilterGamma : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterSphereRefraction : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@objc public protocol CameraControllerDelegate : AnyObject {
  @objc optional func cameraControllerDidCancel(_ cameraController: PixelSDK.CameraController)
  @objc optional func cameraController(_ cameraController: PixelSDK.CameraController, didFinishWithSession session: PixelSDK.Session)
  @objc optional func cameraController(_ cameraController: PixelSDK.CameraController, willShowEditController editController: PixelSDK.EditController, withSession session: PixelSDK.Session)
}
public enum CameraControlButton {
  case cross
  case reverse
  case brightness
  case square
  case flash
  case spacer
  public static func == (a: PixelSDK.CameraControlButton, b: PixelSDK.CameraControlButton) -> Swift.Bool
  public var hashValue: Swift.Int {
    get
  }
  public func hash(into hasher: inout Swift.Hasher)
}
@objc @_hasMissingDesignatedInitializers @objcMembers public class CameraController : UIKit.UIViewController {
  @objc weak public var delegate: PixelSDK.CameraControllerDelegate?
  @objc public var showsEditControllerWhenDone: Swift.Bool
  @objc public var flashActive: Swift.Bool {
    @objc get
    @objc set
  }
  @objc public var frontFacingCameraActive: Swift.Bool {
    @objc get
    @objc set
  }
  @objc public var squareCameraActive: Swift.Bool {
    @objc get
    @objc set
  }
  @objc public var brightnessAdjustmentActive: Swift.Bool {
    @objc get
    @objc set
  }
  @objc public var faceUpModeAvailable: Swift.Bool
  @objc public var doubleTapForFrontFacingCamera: Swift.Bool {
    @objc get
    @objc set
  }
  public var controlButtons: [PixelSDK.CameraControlButton] {
    get
    set
  }
  public var aspectRatio: CoreGraphics.CGSize?
  @objc public var videoPreset: AVFoundation.AVCaptureSession.Preset {
    @objc get
    @objc set
  }
  @objc public var photoSettings: () -> (AVFoundation.AVCapturePhotoSettings) {
    @objc get
    @objc set
  }
  @objc override dynamic public func viewDidLoad()
  @objc override dynamic public func viewWillAppear(_ animated: Swift.Bool)
  @objc override dynamic public func viewDidAppear(_ animated: Swift.Bool)
  @objc override dynamic public func viewWillDisappear(_ animated: Swift.Bool)
  @objc override dynamic public func viewDidDisappear(_ animated: Swift.Bool)
  @objc override dynamic public func viewWillLayoutSubviews()
  @objc override dynamic public func willTransition(to newCollection: UIKit.UITraitCollection, with coordinator: UIKit.UIViewControllerTransitionCoordinator)
  @objc override dynamic public func viewWillTransition(to size: CoreGraphics.CGSize, with coordinator: UIKit.UIViewControllerTransitionCoordinator)
  @objc deinit
  @objc override dynamic public var preferredStatusBarStyle: UIKit.UIStatusBarStyle {
    @objc get
  }
  @objc override dynamic public init(nibName nibNameOrNil: Swift.String?, bundle nibBundleOrNil: Foundation.Bundle?)
}
extension CameraController : PixelSDK.BottomBarProvider {
  @objc dynamic public func setNeedsBottomBarAppearanceUpdate()
  @objc dynamic public var preferredBottomBarView: UIKit.UIView? {
    @objc get
  }
  @objc dynamic public var prefersBottomBarHidden: Swift.Bool {
    @objc get
  }
}
extension CameraController {
  @objc dynamic public var prefersBottomBarTransparent: Swift.Bool {
    @objc get
  }
}
public protocol SessionFilterControllerAdditions {
  func cancel(animated: Swift.Bool, completion: (() -> Swift.Void)?)
  func done(animated: Swift.Bool, completion: (() -> Swift.Void)?)
}
extension SessionFilterControllerAdditions where Self : UIKit.UIViewController {
  public func cancel(animated: Swift.Bool, completion: (() -> Swift.Void)? = nil)
  public func done(animated: Swift.Bool, completion: (() -> Swift.Void)? = nil)
}
@_inheritsConvenienceInitializers open class SessionFilterPolkaDot : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override public func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterLaCienega : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@objc @_hasMissingDesignatedInitializers @objcMembers public class SessionVideo : ObjectiveC.NSObject, Swift.Codable {
  @objc public var renderSize: CoreGraphics.CGSize {
    @objc get
    @objc set
  }
  @objc public var videoSegments: [PixelSDK.SessionVideoSegment] {
    @objc get
  }
  public var primaryFilter: PixelSDK.SessionFilter? {
    get
    set
  }
  public var filters: [PixelSDK.SessionFilter] {
    get
    set
  }
  @objc public var duration: CoreMedia.CMTime {
    @objc get
  }
  @objc public var frameDuration: CoreMedia.CMTime {
    @objc get
    @objc set
  }
  @objc public var exportedVideoURL: Foundation.URL {
    @objc get
  }
  @objc public var dateExported: Foundation.Date? {
    get
  }
  @objc public var isExported: Swift.Bool {
    @objc get
  }
  required public init(from decoder: Swift.Decoder) throws
  public func encode(to encoder: Swift.Encoder) throws
  @objc deinit
  @objc override dynamic public init()
}
@_inheritsConvenienceInitializers open class SessionFilterHistogram : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterAbbotKinney : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
public enum GridLinesMode {
  case always
  case interaction
  case never
  public static func == (a: PixelSDK.GridLinesMode, b: PixelSDK.GridLinesMode) -> Swift.Bool
  public var hashValue: Swift.Int {
    get
  }
  public func hash(into hasher: inout Swift.Hasher)
}
@objc @_hasMissingDesignatedInitializers @objcMembers public class PreviewCropController : UIKit.UIViewController {
  @objc public var defaultsToAspectFillForPortraitMedia: Swift.Bool
  @objc public var defaultsToAspectFillForLandscapeMedia: Swift.Bool
  public var gridLinesMode: PixelSDK.GridLinesMode {
    get
    set
  }
  @objc public func flashGridLines()
  public var aspectRatio: CoreGraphics.CGSize?
  @objc public var maxRatioForPortraitMedia: CoreGraphics.CGSize {
    @objc get
    @objc set
  }
  @objc public var maxRatioForLandscapeMedia: CoreGraphics.CGSize {
    @objc get
    @objc set
  }
  @objc public var pausesVideoOnDrag: Swift.Bool
  @objc override dynamic public func viewDidLoad()
  @objc override dynamic public func viewWillAppear(_ animated: Swift.Bool)
  @objc override dynamic public func viewWillLayoutSubviews()
  @objc override dynamic public func viewDidLayoutSubviews()
  @objc override dynamic public func viewWillTransition(to size: CoreGraphics.CGSize, with coordinator: UIKit.UIViewControllerTransitionCoordinator)
  @objc override dynamic public func touchesBegan(_ touches: Swift.Set<UIKit.UITouch>, with event: UIKit.UIEvent?)
  @objc override dynamic public func touchesEnded(_ touches: Swift.Set<UIKit.UITouch>, with event: UIKit.UIEvent?)
  @objc override dynamic public func touchesCancelled(_ touches: Swift.Set<UIKit.UITouch>, with event: UIKit.UIEvent?)
  @objc public func layoutMedia()
  @objc override dynamic public init(nibName nibNameOrNil: Swift.String?, bundle nibBundleOrNil: Foundation.Bundle?)
  @objc deinit
}
extension PreviewCropController : PixelSDK.PreviewControllerDelegate {
  @objc dynamic public func previewControllerWillDisplayMedia(_ previewController: PixelSDK.PreviewController, withSize size: CoreGraphics.CGSize)
  @objc dynamic public func previewControllerDidDisplayMedia(_ previewController: PixelSDK.PreviewController, withSize size: CoreGraphics.CGSize)
}
extension PreviewCropController : UIKit.UIScrollViewDelegate {
  @objc dynamic public func viewForZooming(in scrollView: UIKit.UIScrollView) -> UIKit.UIView?
  @objc dynamic public func scrollViewDidScroll(_ scrollView: UIKit.UIScrollView)
  @objc dynamic public func scrollViewWillBeginDragging(_ scrollView: UIKit.UIScrollView)
  @objc dynamic public func scrollViewDidEndDragging(_ scrollView: UIKit.UIScrollView, willDecelerate decelerate: Swift.Bool)
  @objc dynamic public func scrollViewDidEndDecelerating(_ scrollView: UIKit.UIScrollView)
  @objc dynamic public func scrollViewDidZoom(_ scrollView: UIKit.UIScrollView)
  @objc dynamic public func scrollViewWillBeginZooming(_ scrollView: UIKit.UIScrollView, with view: UIKit.UIView?)
  @objc dynamic public func scrollViewDidEndZooming(_ scrollView: UIKit.UIScrollView, with view: UIKit.UIView?, atScale scale: CoreGraphics.CGFloat)
}
@objc public enum ContentMode : Swift.Int {
  case contentFill
  case contentAspectFit
  case contentAspectFill
  public typealias RawValue = Swift.Int
  public var rawValue: Swift.Int {
    get
  }
  public init?(rawValue: Swift.Int)
}
@objc public protocol PreviewControllerDelegate : AnyObject {
  @objc func previewControllerWillDisplayMedia(_ previewController: PixelSDK.PreviewController, withSize size: CoreGraphics.CGSize)
  @objc func previewControllerDidDisplayMedia(_ previewController: PixelSDK.PreviewController, withSize size: CoreGraphics.CGSize)
}
@objc @_hasMissingDesignatedInitializers @objcMembers public class PreviewController : UIKit.UIViewController {
  @objc dynamic public init()
  @objc weak public var delegate: PixelSDK.PreviewControllerDelegate?
  @objc override dynamic public func viewDidLoad()
  @objc override dynamic public func viewDidDisappear(_ animated: Swift.Bool)
  @objc override dynamic public func viewWillAppear(_ animated: Swift.Bool)
  @objc override dynamic public func didReceiveMemoryWarning()
  @objc public var session: PixelSDK.Session? {
    @objc get
    @objc set
  }
  @objc public var contentMode: PixelSDK.ContentMode {
    @objc get
    @objc set
  }
  @objc public var loops: Swift.Bool {
    @objc get
    @objc set
  }
  @objc dynamic public var isMuted: Swift.Bool {
    @objc get
    @objc set
  }
  @objc public var currentTime: CoreMedia.CMTime {
    @objc get
  }
  public var initialStartTime: CoreMedia.CMTime? {
    get
    set
  }
  @objc public var autoplayEnabled: Swift.Bool
  @objc public var isPlaying: Swift.Bool {
    get
  }
  @objc public func play()
  @objc public func pause()
  @objc override dynamic public init(nibName nibNameOrNil: Swift.String?, bundle nibBundleOrNil: Foundation.Bundle?)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterSaturation : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
extension CGAffineTransform {
  public static func rotated90Degrees(_ naturalSize: CoreGraphics.CGSize) -> CoreGraphics.CGAffineTransform
  public static func rotated180Degrees(_ naturalSize: CoreGraphics.CGSize) -> CoreGraphics.CGAffineTransform
  public static func rotated270Degrees(_ naturalSize: CoreGraphics.CGSize) -> CoreGraphics.CGAffineTransform
}
@_inheritsConvenienceInitializers open class SessionFilterHalftone : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterWarmth : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
extension CMTime : Swift.Codable {
  public init(from decoder: Swift.Decoder) throws
  public func encode(to encoder: Swift.Encoder) throws
}
@objc @_hasMissingDesignatedInitializers @objcMembers public class SessionVideoSegment : ObjectiveC.NSObject, Swift.Codable {
  @objc public var naturalSize: CoreGraphics.CGSize {
    get
  }
  @objc public var actualSize: CoreGraphics.CGSize {
    @objc get
  }
  @objc public var preferredTransform: CoreGraphics.CGAffineTransform {
    @objc get
    @objc set
  }
  public var cropRect: CoreGraphics.CGRect? {
    get
    set
  }
  @objc public func suggestedCropRect() -> CoreGraphics.CGRect
  public var filters: [PixelSDK.SessionFilter] {
    get
    set
  }
  @objc public var trimStartTime: CoreMedia.CMTime {
    @objc get
    @objc set
  }
  @objc public var trimDuration: CoreMedia.CMTime {
    @objc get
    @objc set
  }
  @objc public var duration: CoreMedia.CMTime {
    get
  }
  @objc public var frameDuration: CoreMedia.CMTime {
    @objc get
    @objc set
  }
  @objc public var location: CoreLocation.CLLocation?
  public var latitude: Swift.Double? {
    get
  }
  public var longitude: Swift.Double? {
    get
  }
  @objc public var exportedVideoURL: Foundation.URL {
    @objc get
  }
  @objc public var dateExported: Foundation.Date? {
    get
  }
  @objc public var isExported: Swift.Bool {
    @objc get
  }
  required public init(from decoder: Swift.Decoder) throws
  public func encode(to encoder: Swift.Encoder) throws
  @objc deinit
  public func requestThumbnail(boundingSize: CoreGraphics.CGSize, contentMode: PixelSDK.ContentMode, filter: PixelSDK.SessionFilter? = nil, completion: @escaping ((UIKit.UIImage?) -> Swift.Void))
  @objc public func invalidateThumbnails()
  public func generateFrame(time: CoreMedia.CMTime, cropped: Swift.Bool, maximumSize: CoreGraphics.CGSize? = nil) -> UIKit.UIImage?
  @objc override dynamic public init()
}
public enum ImageExporterError : Swift.Error, Swift.CustomStringConvertible {
  case cancelled
  case watermarked
  case backgroundState
  case destroyed
  case internalError(Swift.Error)
  public var errorDescription: Swift.String {
    get
  }
  public var description: Swift.String {
    get
  }
}
@_hasMissingDesignatedInitializers @objcMembers public class ImageExporter {
  public static let shared: PixelSDK.ImageExporter
  @objc public var isExporting: Swift.Bool {
    @objc get
  }
  public func export(image: PixelSDK.SessionImage, compressionQuality: Swift.Float = 0.95, completion: @escaping (PixelSDK.ImageExporterError?, UIKit.UIImage?) -> Swift.Void)
  @objc public func export(images: [PixelSDK.SessionImage], compressionQuality: Swift.Float = 0.95, progress: ((Swift.Double) -> Swift.Void)? = nil, completion: @escaping (Swift.Error?, [UIKit.UIImage]?) -> Swift.Void)
  @objc public func cancelExport()
  @objc deinit
}
public enum SessionInitError : Swift.Error, Swift.CustomStringConvertible {
  case internalError(Swift.Error)
  public var errorDescription: Swift.String {
    get
  }
  public var description: Swift.String {
    get
  }
}
extension String : Foundation.LocalizedError {
  public var errorDescription: Swift.String? {
    get
  }
}
public enum SessionSource : Swift.String {
  case camera
  case library
  case user
  case drafts
  public typealias RawValue = Swift.String
  public init?(rawValue: Swift.String)
  public var rawValue: Swift.String {
    get
  }
}
public enum MediaType : Swift.Int {
  case image
  case video
  case none
  public typealias RawValue = Swift.Int
  public init?(rawValue: Swift.Int)
  public var rawValue: Swift.Int {
    get
  }
}
@objc @_hasMissingDesignatedInitializers @objcMembers public class Session : ObjectiveC.NSObject, Swift.Codable {
  @objc convenience public init(image: UIKit.UIImage)
  convenience public init(asset: AVFoundation.AVAsset, sessionReady: @escaping (PixelSDK.Session?, PixelSDK.SessionInitError?) -> ())
  convenience public init(assets: [AVFoundation.AVAsset], sessionReady: @escaping (PixelSDK.Session?, PixelSDK.SessionInitError?) -> ())
  convenience public init(assets: [AVFoundation.AVAsset], renderSize: CoreGraphics.CGSize? = nil, sessionReady: @escaping (PixelSDK.Session?, PixelSDK.SessionInitError?) -> ())
  required public init(from decoder: Swift.Decoder) throws
  public func encode(to encoder: Swift.Encoder) throws
  @objc public var image: PixelSDK.SessionImage? {
    get
  }
  @objc public var video: PixelSDK.SessionVideo? {
    get
  }
  public var mediaType: PixelSDK.MediaType {
    get
  }
  @objc public var sessionID: Swift.Int {
    get
  }
  @objc public var dateCreated: Foundation.Date {
    get
  }
  @objc public var dateModified: Foundation.Date {
    get
  }
  public var source: PixelSDK.SessionSource {
    get
  }
  @objc public var userInfo: [Swift.AnyHashable : Any]? {
    @objc get
    @objc set
  }
  @objc public var isSaved: Swift.Bool {
    @objc get
  }
  @objc public var isTransient: Swift.Bool {
    @objc get
    @objc set
  }
  @objc public var destroyed: Swift.Bool {
    get
  }
  @objc public var hidden: Swift.Bool
  @objc public func save()
  @objc public func destroy()
  @objc override dynamic public init()
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterSanVicente : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterHorizontalPerspective : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterVerticalPerspective : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterWilshire : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterHue : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterLuminanceThreshold : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterMulholland : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@_inheritsConvenienceInitializers open class SessionFilterContrast : PixelSDK.SessionFilter {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  override open func encode(to encoder: Swift.Encoder) throws
  @objc override public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc override public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  override public var normalizedIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  @objc override public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc override public var actualIntensityDefault: Swift.Double {
    @objc get
    @objc set
  }
  override public var actualIntensityRange: (Swift.Double, Swift.Double) {
    get
    set
  }
  override open func operation() -> GPUImage.ImageProcessingOperation
  override open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc deinit
}
@objcMembers open class SessionFilter : Swift.Codable {
  @objc required public init()
  required public init(from decoder: Swift.Decoder) throws
  open func encode(to encoder: Swift.Encoder) throws
  public class func fromData(_ data: Foundation.Data) throws -> PixelSDK.SessionFilter
  @objc public func toData() throws -> Foundation.Data
  public func copy() -> PixelSDK.SessionFilter
  @objc public var displayName: Swift.String
  @objc public var version: Swift.String?
  @objc public var distortsOutput: Swift.Bool
  @objc public var cameraThumbnailImage: UIKit.UIImage?
  @objc public var adjustThumbnailImage: UIKit.UIImage?
  @objc open var isActive: Swift.Bool {
    @objc get
  }
  @objc public var normalizedIntensity: Swift.Double {
    @objc get
    @objc set
  }
  @objc public var normalizedIntensityDefault: Swift.Double {
    @objc get
  }
  public var normalizedIntensityRange: (Swift.Double, Swift.Double)
  @objc public var actualIntensity: Swift.Double {
    @objc get
  }
  @objc public var actualIntensityDefault: Swift.Double
  public var actualIntensityRange: (Swift.Double, Swift.Double)
  open func operation() -> GPUImage.ImageProcessingOperation
  @objc public func updateAllOperations()
  open func operationUpdateNeeded(_ op: GPUImage.ImageProcessingOperation)
  @objc open func viewController() -> UIKit.UIViewController
  @objc deinit
}
extension Array where Element : PixelSDK.SessionFilter {
  public func copy() -> [PixelSDK.SessionFilter]
}
extension PixelSDK.BottomBarAnimation : Swift.Equatable {}
extension PixelSDK.BottomBarAnimation : Swift.Hashable {}
extension PixelSDK.Model : Swift.Equatable {}
extension PixelSDK.Model : Swift.Hashable {}
extension PixelSDK.Model : Swift.RawRepresentable {}
extension PixelSDK.CameraControlButton : Swift.Equatable {}
extension PixelSDK.CameraControlButton : Swift.Hashable {}
extension PixelSDK.GridLinesMode : Swift.Equatable {}
extension PixelSDK.GridLinesMode : Swift.Hashable {}
extension PixelSDK.ContentMode : Swift.Equatable {}
extension PixelSDK.ContentMode : Swift.Hashable {}
extension PixelSDK.ContentMode : Swift.RawRepresentable {}
extension PixelSDK.SessionSource : Swift.Equatable {}
extension PixelSDK.SessionSource : Swift.Hashable {}
extension PixelSDK.SessionSource : Swift.RawRepresentable {}
extension PixelSDK.MediaType : Swift.Equatable {}
extension PixelSDK.MediaType : Swift.Hashable {}
extension PixelSDK.MediaType : Swift.RawRepresentable {}
