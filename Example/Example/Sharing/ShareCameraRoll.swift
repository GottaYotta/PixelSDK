//
//  ShareCameraRoll.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 3/2/18.
//  Copyright © 2021 GottaYotta, Inc. All rights reserved.
//

import Foundation
import UIKit
import Photos

class ShareCameraRoll: ShareProtocol {
    weak var controller: UIViewController!
    
    var contentDescription: String?
    
    var completion: ((Bool) -> Void)?
    
    var shareOption: ShareOption { return .cameraRoll }
    
    var videoURL: URL?
    
    var imageURL: URL?
    
    var assetLocalIdentifier: String?
    
    var assetLocalIdentifierResult: String?
    
    func share() {
        PHPhotoLibrary.authorize { (status) in
            if status != .authorized {
                print("Unable to share to Camera Roll since Photo Library access was denied")
                self.completion?(false)
                self.completion = nil
                return
            }
            
            self.shareToCameraRoll()
        }
    }
    
    func shareToCameraRoll() {
        PHPhotoLibrary.shared().performChanges({
            let request:PHAssetChangeRequest
            
            if let image = self.imageURL {
                guard let aRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: image) else {
                    print("Unable to share to Camera Roll since the imageURL was unable to be opened")
                    DispatchQueue.main.async {
                        self.completion?(false)
                        self.completion = nil
                    }
                    return
                }
                request = aRequest
            }
            else if let video = self.videoURL {
                guard let aRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: video) else {
                    print("Unable to share to Camera Roll since the videoURL was unable to be opened")
                    DispatchQueue.main.async {
                        self.completion?(false)
                        self.completion = nil
                    }
                    return
                }
                request = aRequest
            }
            else {
                DispatchQueue.main.async {
                    self.completion?(false)
                    self.completion = nil
                }
                return
            }
            
            self.assetLocalIdentifierResult = request.placeholderForCreatedAsset?.localIdentifier
        }, completionHandler: { (success, error) in
            if !success {
                print("Unable to share to Camera Roll since we could not save the media to the library: \(String(describing: error))")
                DispatchQueue.main.async {
                    self.completion?(false)
                    self.completion = nil
                }
                return
            }
            DispatchQueue.main.async {
                self.completion?(true)
                self.completion = nil
            }
        })
    }
}

