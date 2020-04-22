# Pixel SDK
Pixel SDK is a photo and video editing framework written in Swift.

<p align="center">
<img src="https://www.cdn.pixelsdk.com/assets/img/screenshots/sdk/library_1_border.jpg" alt="Screenshot" width="23%" height="auto" class="docs-screenshot"/>&nbsp;<img src="https://www.cdn.pixelsdk.com/assets/img/screenshots/sdk/edit_1_border.jpg" alt="Screenshot" width="23%" height="auto" class="docs-screenshot"/>&nbsp;<img src="https://www.cdn.pixelsdk.com/assets/img/screenshots/sdk/edit_7_border.jpg" alt="Screenshot" width="23%" height="auto" class="docs-screenshot"/>&nbsp;<img src="https://www.cdn.pixelsdk.com/assets/img/screenshots/sdk/edit_3_border.gif" alt="Screenshot" width="23%" height="auto" class="docs-screenshot"/>
</p>

- [Features](#features)
- [Installation](#installation)
    * [CocoaPods](#cocoapods)
- [Setup](#setup)
- [Getting Started](#getting-started)
    * [Changing Filters](#changing-filters)
    * [Restricting the Editor](#restricting-the-editor)
        + [Images Only](#images-only)
        + [Videos Only](#videos-only)
        + [Square Content Only](#square-content-only)
        + [Library Only](#library-only)
        + [Camera Only](#camera-only)
    * [Setting Maximum Video Duration](#setting-maximum-video-duration)
    * [Presenting the EditController](#presenting-the-editcontroller)
    * [Programmatic Editing](#programmatic-editing)
- [Exporting Media](#exporting-media)
    * [Image Exports](#image-exports)
    * [Video Exports](#video-exports)
    * [Encoding Settings](#encoding-settings)
- [Writing Custom Filters](#writing-custom-filters)
- [Customizing Colors](#customizing-colors)
- [License](#license)

## Features
✅ Fully Customizable Filters w/ 20+ Included Filters and Visual Effects

✅ Vine Style Video Camera

✅ Auto Saving Drafts

✅ Video Segment Composing, Trimming and Re-ordering

✅ Photo and Video Adjustments (Brightness, Vibrance, Saturation, Contrast, Exposure, Hue, Warmth, Sharpness, Gamma, Highlights, Shadows)

✅ Cropping, Rotation, and Horizontal/Vertical Perspective Correction

✅ Adjust Individual Video Segments and Whole Video Composition

✅ Press and Hold Photo/Video to See Original While Editing

✅ Landscape, Portrait and or Square Support

✅ Swipe for Realtime Camera Filters

✅ Top Down Photo Mode

✅ Camera Brightness and Tap to Focus

✅ Share Directly to Facebook, Instagram or Twitter.

✅ Custom Colors, Dark Mode, and Dynamic Type Accessibility Support.

✅ Import Photos and Videos from DSLR Camera. Lightning to USB Cable Required.

✅ RAW Images and 60fps 4K UHD Video Support. HEVC Support.

✅ Full [Documentation](https://www.pixelsdk.com/docs/latest/).

<br>

<p align="center">
<img src="https://www.cdn.pixelsdk.com/assets/img/screenshots/sdk/camera_1_border.jpg" alt="Screenshot" width="23%" height="auto" class="docs-screenshot"/>&nbsp;<img src="https://www.cdn.pixelsdk.com/assets/img/screenshots/sdk/edit_4_border.jpg" alt="Screenshot" width="23%" height="auto" class="docs-screenshot"/>&nbsp;<img src="https://www.cdn.pixelsdk.com/assets/img/screenshots/sdk/edit_5_border.jpg" alt="Screenshot" width="23%" height="auto" class="docs-screenshot"/>&nbsp;<img src="https://www.cdn.pixelsdk.com/assets/img/screenshots/sdk/edit_6_border.jpg" alt="Screenshot" width="23%" height="auto" class="docs-screenshot"/>
</p>

## Requirements
- iPhone and iOS 11+
- Xcode 10.2+

## Installation

### CocoaPods

CocoaPods is a dependency manager for iOS projects. For usage and installation instructions, visit their [website](https://cocoapods.org/). To integrate PixelSDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```
pod 'PixelSDK'
```

Then, run the following command:

```
$ pod install
```

### Setup

Include the following lines in your application Info.plist:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>Photo access is needed so you can select photos from your library.</string>
<key>NSMicrophoneUsageDescription</key>
<string>Microphone access is needed so you can record video with sound.</string>
<key>NSCameraUsageDescription</key>
<string>Camera access is needed so you can take photos.</string>
```
**Note:** More extensive examples can be found in the [Xcode sample project](https://github.com/GottaYotta/PixelSDK/archive/master.zip).

Import PixelSDK into the file you are working on.

```swift
import PixelSDK
```

Present the full editor in response to a user action, for example, clicking a button. The default primary filters and adjustment filters will be used. The editor will support both photo and video of any dimension with access to both the camera and library.
```swift
let container = ContainerController()
container.editControllerDelegate = self

let nav = UINavigationController(rootViewController: container)
nav.modalPresentationStyle = .fullScreen

self.present(nav, animated: true, completion: nil)
```

Also implement its delegate method. This delegate method will be called when the Next button in the EditController is pressed. In response you should either dismiss the UINavigationController or push a new controller on. The below example pushes a blank controller on. You can then use the  `session` parameter to [export your photo or video](#exporting-media) at your own convenience.
```swift
extension ViewController: EditControllerDelegate {

    func editController(_ editController: EditController, didFinishEditing session: Session) {
        let controller = UIViewController()

        editController.navigationController?.pushViewController(controller, animated: true)
    }
}
```

When you are ready to move your app out of testing and into production, [generate an API key](https://www.pixelsdk.com/dashboard/api-keys/) and specify it in your  `application(_, didFinishLaunchingWithOptions:)` of your App Delegate.

```swift
import PixelSDK

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    PixelSDK.setup("YOUR API KEY")

    return true
}
```

 Keep your API key private. If you do not provide an API key or it is invalid, the VideoExporter and ImageExporter will export with a watermark.


## Getting Started

**Note:** More extensive examples can be found in the [Xcode sample project](https://github.com/GottaYotta/PixelSDK/archive/master.zip).
<getting-started-supplement>
### Changing Filters

You can change the primary and adjustment filters. If you do change filters, make sure you do so before any controllers are presented.

A full list of available filters can be found in the [documentation](https://www.pixelsdk.com/docs/latest/) sidebar.

Primary filters are used on the Filter tab of the EditController and are also available on the CameraController.

The below example changes the primary filters:
```swift
PixelSDK.shared.availablePrimaryFilters = {
    [
        SessionFilterWilshire(),
        SessionFilterMontana(),
        SessionFilterSanVicente(),
        SessionFilterMelrose(),
        SessionFilterSepulveda(),
        SessionFilterLaCienega(),
        SessionFilterAbbotKinney(),
        SessionFilterMulholland(),
        SessionFilterSunset()
    ]
}
```
Adjustment filters are used on the Adjust tab of the EditController.

The below example changes the adjustment filters:
```swift
PixelSDK.shared.availableAdjustFilters = {
    [
        SessionFilterBrightness(),
        SessionFilterVibrance(),
        SessionFilterSaturation(),
        SessionFilterContrast(),
        SessionFilterExposure(),
        SessionFilterHue(),
        SessionFilterWarmth(),
        SessionFilterSharpness(),
        SessionFilterGamma(),
        SessionFilterHighlights(),
        SessionFilterShadows()
    ]
}
```

### Restricting the Editor
#### Images Only

The below example shows how to present the editor with only support for images. The user will have access to both the library and camera.
```swift
// Show only the library and photo camera modes in the tab bar
let container = ContainerController(modes: [.library, .photo])
container.editControllerDelegate = self

// Include only images from the users photo library
container.libraryController.fetchPredicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.image.rawValue)
// Include only images from the users drafts
container.libraryController.draftMediaTypes = [.image]

let nav = UINavigationController(rootViewController: container)
nav.modalPresentationStyle = .fullScreen

self.present(nav, animated: true, completion: nil)
```

#### Videos Only

The below example shows how to present the editor with only support for videos. The user will have access to both the library and camera.
```swift
// Show only the library and video camera modes in the tab bar
let container = ContainerController(modes: [.library, .video])
container.editControllerDelegate = self

// Include only videos from the users photo library
container.libraryController.fetchPredicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.video.rawValue)
// Include only videos from the users drafts
container.libraryController.draftMediaTypes = [.video]

let nav = UINavigationController(rootViewController: container)
nav.modalPresentationStyle = .fullScreen

self.present(nav, animated: true, completion: nil)
```

#### Square Content Only

The below example shows how to present the editor with only support for creating square photos and videos. The user will have access to both the library and camera.
```swift
let container = ContainerController()
container.editControllerDelegate = self

// Only allow square content from the library cropper
container.libraryController.previewCropController.aspectRatio = CGSize(width: 1, height: 1)
// Only allow square content from the camera controller
container.cameraController.aspectRatio = CGSize(width: 1, height: 1)
// Turn the square camera on
container.cameraController.squareCameraActive = true
// Make sure we don't include the square camera button
container.cameraController.controlButtons = [.cross, .reverse, .brightness, .flash]

let nav = UINavigationController(rootViewController: container)
nav.modalPresentationStyle = .fullScreen
self.present(nav, animated: true, completion: nil)
```

#### Library Only

The below example show how to present the editor with only support for the library.
```swift
let container = ContainerController(mode: .library)
container.editControllerDelegate = self

let nav = UINavigationController(rootViewController: container)
nav.modalPresentationStyle = .fullScreen
self.present(nav, animated: true, completion: nil)
```

#### Camera Only

The below example show how to present the editor with only support for the video camera.
```swift
let container = ContainerController(mode: .video)
container.editControllerDelegate = self

let nav = UINavigationController(rootViewController: container)
nav.modalPresentationStyle = .fullScreen
self.present(nav, animated: true, completion: nil)
```

### Setting Maximum Video Duration

By default the maximum video duration is 80 seconds. You can change this to any duration you want.

```swift
// Set the maximum video duration to 3 minutes.
PixelSDK.shared.maxVideoDuration = 60*3
```

### Presenting the EditController

If you do not wish to use the ContainerController with the LibraryController or CameraController, you may opt to present only the EditController.

<p align="center">
<img src="https://www.cdn.pixelsdk.com/assets/img/screenshots/sdk/edit_1_border.jpg" alt="Screenshot" width="23%" height="auto" class="docs-screenshot"/>&nbsp;<img src="https://www.cdn.pixelsdk.com/assets/img/screenshots/sdk/edit_2_border.jpg" alt="Screenshot" width="23%" height="auto" class="docs-screenshot"/>&nbsp;<img src="https://www.cdn.pixelsdk.com/assets/img/screenshots/sdk/edit_4_border.jpg" alt="Screenshot" width="23%" height="auto" class="docs-screenshot"/>&nbsp;<img src="https://www.cdn.pixelsdk.com/assets/img/screenshots/sdk/edit_3_border.gif" alt="Screenshot" width="23%" height="auto" class="docs-screenshot"/>
</p>

#### Images
The below example presents the EditController with an image named "test_image" and sets the initial primary filter to SessionFilterWilshire.

```swift
let image = UIImage(named: "test_image")!

let session = Session(image: image)
session.image!.primaryFilter = SessionFilterWilshire()

let editController = EditController(session: session)
editController.delegate = self

let nav = UINavigationController(rootViewController: editController)
nav.modalPresentationStyle = .fullScreen
self.present(nav, animated: true, completion: nil)
```
#### Videos
You may also present the EditController with AVAssets. The below example presents the EditController with two AVAssets named "test.mov" and "test2.mp4" and sets the initial primary filter to SessionFilterWilshire. These two assets will become segments of the video in their respective order.

The session video will automatically inherit its renderSize from the actualSize of the first segment, unless you manually pass a renderSize into the Session initializer. For more information see [Session](https://www.pixelsdk.com/docs/latest/Classes/Session.html) documentation.

```swift
let asset1 = AVAsset(url: Bundle.main.url(forResource: "test", withExtension: "mov")!)
let asset2 = AVAsset(url: Bundle.main.url(forResource: "test2", withExtension: "mp4")!)

let _ = Session(assets: [asset1, asset2], sessionReady: { (session, success) in
    if success {
        // Set the initial primary filter to Wilshire
        session.video!.primaryFilter = SessionFilterWilshire()

        let editController = EditController(session: session)
        editController.delegate = self

        let nav = UINavigationController(rootViewController: editController)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    else {
        print("ERROR: Unable to create session")
    }
})
```

### Programmatic Editing
If you choose to do so, you may make changes to a session programmatically. This is usually not necessary since changes can just be made visually with the EditController.

For example, setting the primaryFilter of an image session:
```swift
session.image!.primaryFilter = SessionFilterWilshire()
```
Applying a brightness filter to the first segment of a video:
```swift
let segment = session.video!.videoSegments.first!
let brightnessFilter = SessionFilterBrightness()
brightnessFilter.normalizedIntensity = 0.2
segment.filters = [brightnessFilter]
```
Applying a vibrance filter to a whole video:
```swift
let vibranceFilter = SessionFilterVibrance()
vibranceFilter.normalizedIntensity = 0.3
session.video!.filters = [vibranceFilter]
```
Trimming a segment so it starts at one second in, with a duration of two seconds:
```swift
let segment = session.video!.videoSegments.first!
segment.trimStartTime = CMTime(seconds: 1, preferredTimescale: segment.duration.timescale)
segment.trimDuration = CMTime(seconds: 2, preferredTimescale: segment.duration.timescale)
```

After making programmatic changes to a session, you should manually call `session.save()`.

If you make programmatic changes to a session that is currently displayed by an EditController it may result in undocumented behavior.


## Exporting Media

#### Image Exports

The below example demonstrates exporting an image:
```swift
if let image = session.image {
    ImageExporter.shared.export(image: image, completion: { (error, uiImage) in
        if let error = error {
            print("Unable to export image: \(error)")
            return
        }

        print("Finished image export with UIImage: \(uiImage!)")
    })
}
```
In addition to exporting as a UIImage, the exported image is saved to file as a JPEG at the `image.exportedImageURL` variable. After your export has completed, you may move, copy or delete this file.

#### Video Exports

The below example demonstrates exporting a video. Characteristics such as frame rate can be set directly on the video.
```swift
if let video = session.video {
    VideoExporter.shared.export(video: video, progress: { progress in
        print("Export progress: \(progress)")
    }, completion: { error in
        if let error = error {
            print("Unable to export video: \(error)")
            return
        }

        print("Finished video export at URL: \(video.exportedVideoURL)")
    })
}
```
After your export has completed, you may move, copy or delete the file found at the `video.exportedVideoURL`.

Keep in mind you can change properties like `video.frameDuration` ([frame rate](https://www.pixelsdk.com/docs/latest/Classes/SessionVideo.html#/c:@M@PixelSDK@objc(cs)SessionVideo(py)frameDuration)) before exporting the video.

You can also change  `video.renderSize` but we recommend you instead set the PreviewCropController aspectRatio and CameraController aspectRatio. See the [square content example](#square-content-only). These properties allow you to preserve video quality by delaying any upscaling or downscaling until a later point in your video processing logic. If you plan on converting your video to HLS on a server that encoder should handle any upscaling or downscaling. If you do decide to change the `video.renderSize` we recommend you still set the aspectRatio variables.

#### Encoding Settings

If you do not customize the video and audio encoding settings, the default settings will be an mp4 file with H.264 video encoding and stereo AAC audio encoding:
```swift
import AVFoundation
```
```swift
var acl = AudioChannelLayout()
memset(&acl, 0, MemoryLayout<AudioChannelLayout>.size)
acl.mChannelLayoutTag = kAudioChannelLayoutTag_Stereo

let audioEncodingSettings: [String: Any] = [
    AVFormatIDKey: kAudioFormatMPEG4AAC,
    AVNumberOfChannelsKey: 2,
    AVSampleRateKey: AVAudioSession.sharedInstance().sampleRate,
    AVChannelLayoutKey: NSData(bytes:&acl, length:MemoryLayout<AudioChannelLayout>.size),
    AVEncoderBitRateKey: 96000
]

let videoEncodingSettings: [String: Any] = [
    AVVideoCompressionPropertiesKey: [
        AVVideoProfileLevelKey: AVVideoProfileLevelH264HighAutoLevel,
        AVVideoH264EntropyModeKey: AVVideoH264EntropyModeCABAC],
    AVVideoCodecKey: AVVideoCodecType.h264
]

VideoExporter.shared.export(video: session.video!,
                            fileType: .mp4,
                            videoEncodingSettings: videoEncodingSettings,
                            audioEncodingSettings: audioEncodingSettings,
                            progress: nil,
                            completion: { error in
})
```
There are many combinations of encoding settings you can provide. They must conform to the specifications set forth in the [AVAssetWriterInput](https://developer.apple.com/documentation/avfoundation/avassetwriterinput/1385912-init). There is also a list of available [codecs](https://developer.apple.com/documentation/avfoundation/avvideocodectype) and [settings](https://developer.apple.com/documentation/avfoundation/avassetwriterinput/video_settings_dictionaries). Keep in mind each codec may have different requirements for the settings you provide.

Below is an example of HEVC video encoding settings:
```swift
import AVFoundation
import VideoToolbox
```
```swift
let videoEncodingSettings: [String: Any] = [
    AVVideoCompressionPropertiesKey: [
        AVVideoProfileLevelKey: kVTProfileLevel_HEVC_Main_AutoLevel],
    AVVideoCodecKey: AVVideoCodecType.hevc
]
```

## Writing Custom Filters

You can easily create your own filters using Photoshop, Lightroom presets, [3D LUT](https://en.wikipedia.org/wiki/3D_lookup_table) files, or your favorite photo editing application. An RGB lookup image is used to remap the colors in photos and videos. This is the same method used by common social media apps. For more complex filters you can chain [GPUImage2](https://github.com/BradLarson/GPUImage2) operations e.g. LookupFilter --> Vibrance --> Sharpen.

**Step 1:** Open any test image of your choosing in your photo editor.

**Step 2:** Apply filters and changes to the test image until you are satisfied with the end result.

**Step 3:** Download the original [lookup.png](https://github.com/GottaYotta/PixelSDK/blob/master/lookup.png) image from the repository and open it in your photo editor.

**Step 4:** Apply the same changes you made on your test image to the lookup.png image and save the result to a new image lookup_example.png. Do not downsize the image or reduce its quality. In some photo editors you can simply copy your adjustment layers from your test image to the lookup image.

**Note:** Each pixel color must be independent of other pixels (e.g. sharpen will not work). If you need a more complex filter you can chain [GPUImage2](https://github.com/BradLarson/GPUImage2) operations e.g. LookupFilter --> Sharpen --> Vibrance. An example of chaining operations is also included in the [Xcode sample project](https://github.com/GottaYotta/PixelSDK/archive/master.zip).

**Step 5:** Use the below code to create your own SessionFilter subclass that utilizes a LookupFilter operation and your newly created lookup_example.png image. Be sure to add your lookup_example.png image to your Xcode project.

```swift
import Foundation
import PixelSDK
import GPUImage

class SessionFilterExample: SessionFilter {
    public required init() {
        super.init()

        self.commonInit()
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)

        self.commonInit()
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }

    func commonInit() {
        self.displayName = "Example Filter"
        self.version = "1.0"
        self.cameraThumbnailImage = UIImage(named: "thumbnail_example.png")

        // self.normalizedIntensityDefault = 100 // This value gets computed
        self.normalizedIntensityRange = (0, 100)
        self.actualIntensityDefault = 1
        self.actualIntensityRange = (0, 1)
    }

    override public func operation() -> ImageProcessingOperation {
        let lookupFilter = LookupFilter()

        do {
            lookupFilter.lookupImage = try PictureInput(image: UIImage(named: "lookup_example.png")!)
        }
        catch {
            print("ERROR: Unable to create PictureInput \(error)")
        }

        return lookupFilter
    }

    override public func operationUpdateNeeded(_ op: ImageProcessingOperation) {
        let op = op as! LookupFilter

        op.intensity = Float(self.actualIntensity)
    }
}

```

**Step 6:** Include your custom filter in the list of available filters. Do this before your present the ContainerController or EditController.

```swift
PixelSDK.shared.availablePrimaryFilters = {
    [
        SessionFilterExample(), // Your custom filter
        SessionFilterWilshire(),
        SessionFilterMontana(),
        SessionFilterSanVicente(),
        SessionFilterMelrose(),
        SessionFilterSepulveda(),
        SessionFilterLaCienega(),
        SessionFilterAbbotKinney(),
        SessionFilterMulholland(),
        SessionFilterSunset()
    ]
}
```

That's it! Enjoy your new custom filter.

## Customizing Colors

You can customize UI colors in the framework by adding color assets to your asset catalog:

<img src="https://www.cdn.pixelsdk.com/assets/img/docs/add_color_asset.jpg" alt="Add Color Asset" width="341" height="auto" class="docs-screenshot"/>

The color assets you add can have any of the following names:

<table class="table table-bordered table-striped" style="width:initial;">
<tr><td><img src="https://www.cdn.pixelsdk.com/assets/img/docs/colors/theme_color.svg" /></td><td>Pixel SDK Theme Color</td></tr>
<tr><td><img src="https://www.cdn.pixelsdk.com/assets/img/docs/colors/label_color.svg" /></td><td>Pixel SDK Label Color</td></tr>
<tr><td><img src="https://www.cdn.pixelsdk.com/assets/img/docs/colors/label_inactive_color.svg" /></td><td>Pixel SDK Label Inactive Color</td></tr>
<tr><td><img src="https://www.cdn.pixelsdk.com/assets/img/docs/colors/shadow_color.svg" /></td><td>Pixel SDK Shadow Color</td></tr>
<tr><td><img src="https://www.cdn.pixelsdk.com/assets/img/docs/colors/background_color.svg" /></td><td>Pixel SDK Background Color</td></tr>
<tr><td><img src="https://www.cdn.pixelsdk.com/assets/img/docs/colors/placeholder_color.svg" /></td><td>Pixel SDK Placeholder Color</td></tr>
<tr><td><img src="https://www.cdn.pixelsdk.com/assets/img/docs/colors/destructive_color.svg" /></td><td>Pixel SDK Destructive Color</td></tr>
<tr><td><img src="https://www.cdn.pixelsdk.com/assets/img/docs/colors/face_up_color.svg" /></td><td>Pixel SDK Face Up Color</td></tr>
<tr><td><img src="https://www.cdn.pixelsdk.com/assets/img/docs/colors/camera_overlay_color.svg" /></td><td>Pixel SDK Camera Overlay Color</td></tr>
<tr><td><img src="https://www.cdn.pixelsdk.com/assets/img/docs/colors/gray_1_color.svg" /></td><td>Pixel SDK Gray 1 Color</td></tr>
<tr><td><img src="https://www.cdn.pixelsdk.com/assets/img/docs/colors/gray_2_color.svg" /></td><td>Pixel SDK Gray 2 Color</td></tr>
<tr><td><img src="https://www.cdn.pixelsdk.com/assets/img/docs/colors/gray_3_color.svg" /></td><td>Pixel SDK Gray 3 Color</td></tr>
<tr><td><img src="https://www.cdn.pixelsdk.com/assets/img/docs/colors/gray_4_color.svg" /></td><td>Pixel SDK Gray 4 Color</td></tr>
<tr><td><img src="https://www.cdn.pixelsdk.com/assets/img/docs/colors/gray_5_color.svg" /></td><td>Pixel SDK Gray 5 Color</td></tr>
<tr><td><img src="https://www.cdn.pixelsdk.com/assets/img/docs/colors/white_color.svg" /></td><td>Pixel SDK White Color</td></tr>
</table>

The [Xcode sample project](https://github.com/GottaYotta/PixelSDK/archive/master.zip) includes all available color assets with their default colors. If you do not provide color assets, the default colors will be used.

## License

See our [Terms of Use](https://www.pixelsdk.com/terms-of-use/) and [Privacy Policy](https://www.pixelsdk.com/privacy-policy/).
