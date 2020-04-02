//
//  ShareMail.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 3/11/18.
//  Copyright © 2018 GottaYotta, Inc. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class ShareMail: NSObject, ShareProtocol, MFMailComposeViewControllerDelegate {
    
    weak var controller: UIViewController!
    
    var contentDescription: String?
    
    var completion: ((Bool) -> Void)?
    
    var shareOption: ShareOption { return .mail }
    
    var videoURL: URL?
    
    var imageURL: URL?
    
    var assetLocalIdentifier: String?
    
    private var strongSelf: ShareMail?
    
    func share() {
        if !self.shareOption.isInstalled() {
            print("Unable to share to Mail since it is not installed")
            self.completion?(false)
            self.completion = nil
            return
        }
        
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
         
        if let description = self.contentDescription {
            composeVC.setMessageBody(description, isHTML: false)
        }
        
        if let imageURL = self.imageURL {
            guard let data = FileManager.default.contents(atPath: imageURL.path) else {
                print("Unable to share to Mail since the image could not be opened")
                self.completion?(false)
                self.completion = nil
                return
            }
            
            composeVC.addAttachmentData(data, mimeType: "image/jpeg", fileName: "image.jpg")
        }
        else if let videoURL = self.videoURL {
            guard let data = FileManager.default.contents(atPath: videoURL.path) else {
                print("Unable to share to Mail since the video could not be opened")
                self.completion?(false)
                self.completion = nil
                return
            }
            
            composeVC.addAttachmentData(data, mimeType: "video/mp4", fileName: "video.mp4")
        }
        
        self.strongSelf = self
        
        self.controller.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
        switch result {
        case .cancelled:
            self.completion?(false)
        case .saved:
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
