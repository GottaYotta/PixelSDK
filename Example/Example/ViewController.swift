//
//  ViewController.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 8/1/19.
//  Copyright © 2019 GottaYotta, Inc. All rights reserved.
//

import UIKit
import PixelSDK
import PhotosUI

class ViewController: UITableViewController {
    
    @IBOutlet var activityIndicatorView1: UIActivityIndicatorView!
    @IBOutlet var activityIndicatorView2: UIActivityIndicatorView!
    
    var alertShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        #if targetEnvironment(simulator)
        if !alertShown {
            let alert = UIAlertController(title: "Simulator Warning", message: "The Xcode simulator has limited functionality (no camera or high quality media) and is very slow.\nWe recommend you run this on a physical device instead.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            alertShown = true
        }
        #endif
    }
    
    @IBAction func fullEditorWithInstaFilters() {
        PixelSDK.shared.availablePrimaryFilters = PixelSDK.instaFilters
        
        let container = ContainerController()
        container.editControllerDelegate = self
        
        let nav = UINavigationController(rootViewController: container)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func fullEditorWithVisualEffectFilters() {
        PixelSDK.shared.availablePrimaryFilters = PixelSDK.visualEffectFilters
        
        let container = ContainerController()
        container.editControllerDelegate = self
        
        let nav = UINavigationController(rootViewController: container)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func fullEditorWithCustomFilters() {
        PixelSDK.shared.availablePrimaryFilters = {
            [
                SessionFilterExample1(),
                SessionFilterExample2(),
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
        
        let container = ContainerController()
        container.editControllerDelegate = self
        
        let nav = UINavigationController(rootViewController: container)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func onlyLibraryController() {
        let container = ContainerController(mode: .library)
        container.editControllerDelegate = self
        
        let nav = UINavigationController(rootViewController: container)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func onlyVideoCameraController() {
        let container = ContainerController(mode: .video)
        container.editControllerDelegate = self
        
        let nav = UINavigationController(rootViewController: container)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func onlyPhotoCameraController() {
        let container = ContainerController(mode: .photo)
        container.editControllerDelegate = self
        
        let nav = UINavigationController(rootViewController: container)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func squareContentOnly() {
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
    }
    
    @IBAction func editControllerWithCustomImageSession() {
        let image = UIImage(named: "test_image")!
        
        let session = Session(image: image)
        
        // Initialize the EditController
        let editController = EditController(session: session)
        editController.delegate = self
        
        // Present the EditController
        let nav = UINavigationController(rootViewController: editController)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func editControllerWithCustomVideoSession() {
        // NOTE: The session video will automatically inherit its renderSize from the actualSize of the first segment (asset) unless you pass a renderSize parameter to the session initializer.
        let asset1 = AVAsset(url: Bundle.main.url(forResource: "test_1", withExtension: "mov")!)
        let asset2 = AVAsset(url: Bundle.main.url(forResource: "test_2", withExtension: "mp4")!)
        let asset3 = AVAsset(url: Bundle.main.url(forResource: "test_3", withExtension: "mp4")!)
        
        let _ = Session(assets: [asset1, asset2, asset3], sessionReady: { (session, error) in
            self.activityIndicatorView1.stopAnimating()
            self.activityIndicatorView1.isHidden = true
            
            guard let session = session,
                let video = session.video else {
                print("Unable to create session: \(error!)")
                return
            }
            
            // Set the initial primary filter to Sepulveda
            video.primaryFilter = SessionFilterSepulveda()
            
            // Apply a Brightness filter to the first segment
            let brightnessFilter = SessionFilterBrightness()
            brightnessFilter.normalizedIntensity = 0.2
            video.videoSegments.first!.filters = [brightnessFilter]
            
            // Initialize the EditController
            let editController = EditController(session: session)
            editController.delegate = self
            
            // Present the EditController
            let nav = UINavigationController(rootViewController: editController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        })
        
        self.activityIndicatorView1.startAnimating()
        self.activityIndicatorView1.isHidden = false
    }

    @IBAction func imageContentOnly() {
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
    }
    
    @IBAction func videoContentOnly() {
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
    }
    
    @IBAction func customViewControllerInTabBar() {
        let myController = UIViewController()
        myController.view.backgroundColor = .purple
        
        let container = ContainerController(modes: [.library, .photo, .video, .custom(title: "Custom", controller: myController)])
        container.editControllerDelegate = self
        let nav = UINavigationController(rootViewController: container)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func transcodeVideoWithFilters() {
        // NOTE: The session video will automatically inherit its renderSize from the actualSize of the first segment (asset) unless you pass a renderSize parameter to the session initializer.
        let asset1 = AVAsset(url: Bundle.main.url(forResource: "test_1", withExtension: "mov")!)
        let asset2 = AVAsset(url: Bundle.main.url(forResource: "test_2", withExtension: "mp4")!)
        let asset3 = AVAsset(url: Bundle.main.url(forResource: "test_3", withExtension: "mp4")!)
        
        let _ = Session(assets: [asset1, asset2, asset3], sessionReady: { (session, error) in
            guard let session = session,
                let video = session.video else {
                print("Unable to create session: \(error!)")
                return
            }
            
            // Mark the session as transient so it does not appear in the users drafts and persist on disk
            session.isTransient = true
            
            // Set the video frame rate to 60 fps
            video.frameDuration = CMTime(value: 1, timescale: 60)
            
            // Apply a Saturation filter to the first segment
            let saturationFilter = SessionFilterSaturation()
            saturationFilter.normalizedIntensity = 0.2
            video.videoSegments[0].filters = [saturationFilter]
            
            // Apply a Pixellate filter to the second segment
            let pixellateFilter = SessionFilterPixellate()
            video.videoSegments[1].filters = [pixellateFilter]
            
            // Write to an MP4 file with H.264 video encoding and stereo AAC audio encoding
            
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
            
            VideoExporter.shared.export(video: video,
                                        fileType: .mp4,
                                        videoEncodingSettings: videoEncodingSettings,
                                        audioEncodingSettings: audioEncodingSettings,
                                        progress: { (progress) in
                print("Transcode progress: \(progress)")
            }, completion: { (error) in
                self.activityIndicatorView2.stopAnimating()
                self.activityIndicatorView2.isHidden = true
                
                if let error = error {
                    print("Unable to transcode video: \(error)")
                    return
                }
                
                print("Finished video transcode at URL: \(video.exportedVideoURL)")
                
                let controller = UIAlertController(title: "Success", message: "Your video has been transcoded", preferredStyle: .alert)
                controller.addAction(.init(title: "Ok", style: .cancel, handler: nil))
                self.present(controller, animated: true, completion: nil)
            })
        })
        
        self.activityIndicatorView2.startAnimating()
        self.activityIndicatorView2.isHidden = false
    }
}

// MARK: - EditControllerDelegate

extension ViewController: EditControllerDelegate {
    
    func editController(_ editController: EditController, willBeginEditing session: Session) {
        // Called when the EditController's view will appear.
    }
    
    func editController(_ editController: EditController, didBeginEditing session: Session) {
        // Called when the EditController's view did appear.
    }
    
    func editController(_ editController: EditController, didFinishEditing session: Session) {
        // Called when the Next button in the EditController is pressed.
        // Use this time to either dismiss the UINavigationController, or push a new controller on.
        
        let controller = PostController()
        controller.session = session
        editController.navigationController?.pushViewController(controller, animated: true)
    }
    
    func editController(_ editController: EditController, didCancelEditing session: Session?) {
        // Called when the back button in the EditController is pressed.
    }
}
