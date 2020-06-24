# Changelog

### 7.0.2 - 6/23/20

&bull; Fix bug which prevented the framework from being compiled on Swift 5.3

### 7.0.1 - 6/23/20

&bull; Fix bug which would occasionally cause media to layout incorrectly in the `PreviewCropController`<br>
&bull; Various bug fixes and stability improvements

### 7.0.0 - 6/22/20

&bull; Added iPad support<br>
&bull; Added tab bar customization in `EditController`<br>
&bull; Added support for custom `EditController` UIViewControllers<br>
&bull; Added real-time `PreviewController` updates after making programmatic changes to a `Session`<br>
&bull; Fix infrequent crash from adjusting intensity slider/rotation on video sessions<br>
&bull; Changed variables for primary/adjustment filters from closures to arrays<br>
&bull; Various bug fixes and stability improvements

### 6.1.0 - 6/15/20

&bull; Added support for custom `SessionFilter` UIViewControllers<br>
&bull; Added support for filtered thumbnails in the `requestThumbnail()` function<br>
&bull; Fix bug which prevented custom colors from working properly on iOS 11 and 12<br>
&bull; Various bug fixes and stability improvements

### 6.0.0 - 6/10/20

&bull; Fix bug which prevented user defined SessionFilters from being properly encoded/decoded<br>
&bull; Fix bug where CameraController/ContainerController delegate was called prematurely before photo capture had finished<br>
&bull; Added Objective-C support to ContainerControllerDelegate<br>
&bull; Renamed ContainerControllerDelegate function from `func containerController(_ containerController: ContainerController, didChangeMode mode: ContainerMode)` to `func containerControllerDidChangeMode(_ containerController: ContainerController)`<br>
&bull; Various bug fixes and stability improvements

### 5.5.0 - 6/10/20
&bull; Fix bug which prevented the EditController cancel/revert button from working properly in some cases<br>
&bull; Added ability to copy SessionFilters and convert them to/from data

### 5.4.0 - 6/9/20
&bull; Fix safe area insets on iOS 13 when UIApplicationSceneManifest is specified in Info.plist<br>
&bull; Added `compactControls` variable to EditController<br>
&bull; Exposed `backButton` and `nextButton` variables in EditController<br>
&bull; Fix UIAlertController broken constraint warning<br>
&bull; Added UIImpactFeedbackGenerator for changing scrub speed<br>
&bull; Fix bug which prevented an image session from being used if PixelSDK.setup() is not present<br>
&bull; Fix bug which prevented an image session from being exported immediately after it was created<br>
&bull; Various bug fixes and stability improvements 

### 5.3.0 - 5/22/20
&bull; Added localized strings for Vignette filter

### 5.2.0 - 5/21/20
&bull; Added Vignette support in adjustments

### 5.1.2 - 5/14/20
&bull; Fix bug which infrequently caused the bottom bar to not appear on the position/crop controller for video

### 5.1.1 - 5/7/20
&bull; Fix missing localized strings for "Drag to delete" and "Original"<br>
&bull; Fix crash caused by Save to Camera Roll and some library updates if the users albums had been previously loaded

### 5.1.0 - 5/4/20
&bull; Added localizations<br>
&bull; Preload albums to eliminate loading delay on LibraryController<br>
&bull; Fix bug where navigation bar would briefly appear when adding a segment

### 5.0.0 - 4/28/20
&bull; Added transcoder examples<br>
&bull; Improved Session initializer error reporting

### 4.0.5 - 4/23/20
&bull; Fix bug which prevented image rotation<br>
&bull; Fix issue where init was not exposed for some adjustment filters

### 4.0.3 - 4/6/20
&bull; Fix PixelSDK.setup() issue

### 4.0.2 - 4/5/20
&bull; Fix bug in Simulator which could result in a temporary main thread block while cropping media

### 4.0.1 - 4/2/20
&bull; Bug fixes

### 4.0.0 - 4/1/20
&bull; Initial release
