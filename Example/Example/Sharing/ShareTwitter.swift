//
//  ShareTwitter.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 3/11/18.
//  Copyright © 2021 GottaYotta, Inc. All rights reserved.
//

import Foundation
import UIKit
import Social
import Photos

class ShareTwitter: ShareProtocol {
    
    weak var controller: UIViewController!
    
    var contentDescription: String?
    
    var completion: ((Bool) -> Void)?
    
    var shareOption: ShareOption { return .twitter }
    
    var videoURL: URL?
    
    var imageURL: URL?
    
    var assetLocalIdentifier: String?
    
    func share() {
        if !self.shareOption.isInstalled() {
            print("Unable to share to Twitter since it is not installed")
            self.completion?(false)
            self.completion = nil
            return
        }
        
        guard let composeController = SLComposeViewController(forServiceType: "com.apple.social.twitter") else {
            print("Unable to share to Twitter since the SLComposeViewController could not be created")
            self.completion?(false)
            self.completion = nil
            return
        }

        if let description = self.contentDescription {
            composeController.setInitialText(description)
        }
        
        if let imageURL = self.imageURL {
            guard let image = UIImage(contentsOfFile: imageURL.path) else {
                print("Unable to share to Twitter since the image could not be opened")
                self.completion?(false)
                self.completion = nil
                return
            }
            
            composeController.add(image)
        }
        else if let _ = self.videoURL { // Video
            print("Unable to share to Twitter since the videos are not supported")
            self.completion?(false)
            self.completion = nil
            return
        }
        
        composeController.completionHandler = { result in
            composeController.dismiss(animated: true, completion: nil)
            
            switch result {
            case .cancelled:
                self.completion?(false)
            case .done:
                self.completion?(true)
            @unknown default:
                self.completion?(false)
            }
            self.completion = nil
        }
        
        self.controller.present(composeController, animated: true, completion: nil)
    }
}
