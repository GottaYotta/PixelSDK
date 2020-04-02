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
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    var alertShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        #if targetEnvironment(simulator)
        if !alertShown {
            let alert = UIAlertController(title: "Simulator Warning", message: "The simulator has no camera, GPU processing on it is extremely slow, and it does not support high quality media. It is recommended you run this on a physical device instead.", preferredStyle: .alert)
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
        container.cameraController.faceUpModeAvailable = false
        
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
        
        let editController = EditController(session: session)
        editController.delegate = self
        
        let nav = UINavigationController(rootViewController: editController)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func editControllerWithCustomVideoSession() {
        self.activityIndicatorView.startAnimating()
        self.activityIndicatorView.isHidden = false
        
        // NOTE: The session video will automatically inherit its renderSize from the actualSize of the first segment (asset) unless you pass a renderSize parameter to the session initializer.
        let asset1 = AVAsset(url: Bundle.main.url(forResource: "test_1", withExtension: "mov")!)
        let asset2 = AVAsset(url: Bundle.main.url(forResource: "test_2", withExtension: "mp4")!)
        let asset3 = AVAsset(url: Bundle.main.url(forResource: "test_3", withExtension: "mp4")!)
        
        let _ = Session(assets: [asset1, asset2, asset3], sessionReady: { (session, success) in
            if success {
                // Set the initial primary filter to Sepulveda
                session.video!.primaryFilter = SessionFilterSepulveda()
                
                // Set the brightness of the first segment
                let brightnessFilter = SessionFilterBrightness()
                brightnessFilter.normalizedIntensity = 0.2
                session.video!.videoSegments.first!.filters = [brightnessFilter]
                
                let editController = EditController(session: session)
                editController.delegate = self
                
                let nav = UINavigationController(rootViewController: editController)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
            else {
                print("ERROR: Unable to create session")
            }

            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.isHidden = true
        })
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
