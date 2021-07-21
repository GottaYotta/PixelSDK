//
//  ShareMessage.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 3/11/18.
//  Copyright © 2021 GottaYotta, Inc. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class ShareMessage: NSObject, ShareProtocol, MFMessageComposeViewControllerDelegate {
    
    weak var controller: UIViewController!
    
    var contentDescription: String?
    
    var completion: ((Bool) -> Void)?
    
    var shareOption: ShareOption { return .message }
    
    var videoURL: URL?
    
    var imageURL: URL?
    
    var assetLocalIdentifier: String?
    
    private var strongSelf: ShareMessage?
    
    func share() {
        if !self.shareOption.isInstalled() {
            print("Unable to share to Messages since it is not installed")
            self.completion?(false)
            self.completion = nil
            return
        }
        
        
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
         
        composeVC.body = self.contentDescription
        
        if let imageURL = self.imageURL {
            composeVC.addAttachmentURL(imageURL, withAlternateFilename: nil)
        }
        else if let videoURL = self.videoURL {
            composeVC.addAttachmentURL(videoURL, withAlternateFilename: nil)
        }
        
        self.strongSelf = self
        
        self.controller.present(composeVC, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        
        switch result {
        case .cancelled:
            self.completion?(false)
        case .sent:
            self.completion?(true)
        case .failed:
            self.completion?(false)
        @unknown default:
            self.completion?(false)
        }
        self.completion = nil
        
        self.strongSelf = nil
    }
}
