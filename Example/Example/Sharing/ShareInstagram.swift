//
//  ShareInstagram.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 3/2/18.
//  Copyright © 2021 GottaYotta, Inc. All rights reserved.
//

import Foundation
import UIKit

class ShareInstagram: ShareProtocol {

    weak var controller: UIViewController!
    
    var contentDescription: String?
    
    var completion: ((Bool) -> Void)?
    
    var shareOption: ShareOption { return .instagram }
    
    var videoURL: URL?
    
    var imageURL: URL?
    
    var assetLocalIdentifier: String?
    
    var strongSelf: ShareInstagram?
    
    func share() {
        if !self.shareOption.isInstalled() {
            print("Unable to share to Instagram since it is not installed")
            self.completion?(false)
            self.completion = nil
            return
        }
        
        if let description = self.contentDescription {
            UIPasteboard.general.string = description
        }
        
        let shareURL: URL
        if let assetLocalIdentifier = self.assetLocalIdentifier,
            let aShareURL = URL(string: "instagram://library?LocalIdentifier=" + assetLocalIdentifier) {
            shareURL = aShareURL
        }
        else {
            print("Unable to properly share to Instagram since the instagram://library?LocalIdentifier= URL could not be constructed")
            shareURL = URL(string: "instagram://library")!
        }
        
        // Prevent the class from deallocating until the completion block is called
        self.strongSelf = self
        
        UIApplication.shared.open(shareURL, options: [:]) { success in
            if success {
                // Call the success block when they come back into the app
                NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
            }
            else {
                print("Unable to share to Instagram since the user declined opening Instagram")
                self.completion?(false)
                self.completion = nil
                self.strongSelf = nil
                return
            }
        }
    }
    
    @objc func applicationDidBecomeActive() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        
        self.completion?(true)
        self.completion = nil
        self.strongSelf = nil
    }

}
