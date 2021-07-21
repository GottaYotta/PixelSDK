//
//  ShareFacebook.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 3/9/18.
//  Copyright © 2021 GottaYotta, Inc. All rights reserved.
//

import Foundation
import UIKit
import Social
import Photos

class ShareFacebook: ShareProtocol {

    weak var controller: UIViewController!
    
    var contentDescription: String?
    
    var completion: ((Bool) -> Void)?
    
    var shareOption: ShareOption { return .facebook }
    
    var videoURL: URL?
    
    var imageURL: URL?
    
    var assetLocalIdentifier: String?
    
    func share() {
        if !self.shareOption.isInstalled() {
            print("Unable to share to Facebook since it is not installed")
            self.completion?(false)
            self.completion = nil
            return
        }
        
        guard let composeController = SLComposeViewController(forServiceType: "com.apple.social.facebook") else {
            print("Unable to share to Facebook since the SLComposeViewController could not be created")
            self.completion?(false)
            self.completion = nil
            return
        }

        if let description = self.contentDescription {
            UIPasteboard.general.string = description
        }
        
        if let imageURL = self.imageURL {
            guard let image = UIImage(contentsOfFile: imageURL.path) else {
                print("Unable to share to Facebook since the image could not be opened")
                self.completion?(false)
                self.completion = nil
                return
            }
            
            composeController.add(image)
        }
        else if let _ = self.videoURL { // Video
            guard let assetLocalIdentifier = self.assetLocalIdentifier,
                let phAsset = PHAsset.fetchAssets(withLocalIdentifiers: [assetLocalIdentifier], options: nil).firstObject else {
                    print("Unable to share to Facebook since the PHAsset could not be retrieved")
                    self.completion?(false)
                    self.completion = nil
                    return
            }
            
            // Obtain the legacy "assets-library" URL from PHAsset. This is the same method used by the facebook-ios-sdk.
            // Source: https://github.com/facebook/facebook-ios-sdk/blob/master/FBSDKShareKit/FBSDKShareKit/FBSDKShareVideo.m
            phAsset.requestAssetsLibraryURL { (assetsLibraryURL) in
                if let assetsLibraryURL = assetsLibraryURL {
                    composeController.add(assetsLibraryURL)
                }
                else {
                    print("Unable to share to Facebook since the assetsLibraryURL could not be retrieved")
                    self.completion?(false)
                    self.completion = nil
                    return
                }
            }
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
