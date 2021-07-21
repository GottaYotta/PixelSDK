//
//  PHAsset+Additions.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 11/21/19.
//  Copyright © 2021 GottaYotta, Inc. All rights reserved.
//

import Foundation
import UIKit
import Photos
import Dispatch

extension PHAsset {
    /// Obtain the legacy "assets-library" URL from PHAsset. This is the same method used by the facebook-ios-sdk.
    /// Source: https://github.com/facebook/facebook-ios-sdk/blob/master/FBSDKShareKit/FBSDKShareKit/FBSDKShareVideo.m
    func requestAssetsLibraryURL(completion: @escaping (URL?) -> Void) {
        self.requestAssetURL { (filePathURL) in
            guard let filePathURL = filePathURL else {
                completion(nil)
                return
            }
            
            let pathExtension = filePathURL.pathExtension
            let localIdentifier = self.localIdentifier
            if let range = localIdentifier.range(of: "/") {
                let uuid = localIdentifier[..<range.lowerBound]
                let assetPath = "assets-library://asset/asset.\(pathExtension)?id=\(uuid)&ext=\(pathExtension)"
                let videoURL = URL(string: assetPath)
                completion(videoURL)
            }
            else {
                completion(nil)
            }
        }
    }
    
    func requestAssetURL(completion: @escaping (URL?) -> Void) {
        let options = PHVideoRequestOptions()
        options.version = .current
        options.deliveryMode = .automatic
        options.isNetworkAccessAllowed = true
        
        PHImageManager.default().requestAVAsset(forVideo: self, options: options) { (avAsset, audioMix, info) in
            DispatchQueue.main.async {
                guard let avAsset = avAsset as? AVURLAsset else {
                    completion(nil)
                    return
                }
                
                completion(avAsset.url)
            }
        }
    }
}
