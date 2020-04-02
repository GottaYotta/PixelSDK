//
//  ShareManager.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 2/15/18.
//  Copyright © 2018 GottaYotta, Inc. All rights reserved.
//

import Foundation
import UIKit
import PixelSDK
import MessageUI

enum ShareOption: String {
    case twitter
    case instagram
    case facebook
    case cameraRoll
    case message
    case mail
    
    var displayName: String {
        get {
            switch self {
            case .twitter:
                return "Twitter"
            case .instagram:
                return "Instagram"
            case .facebook:
                return "Facebook"
            case .cameraRoll:
                return "Camera Roll"
            case .message:
                return "Message"
            case .mail:
                return "Mail"
            }
        }
    }
    
    var smallLogoImage: UIImage? {
        get {
            switch self {
            case .twitter:
                return UIImage(named: "cam_upload_logo_twitter")!
            case .instagram:
                return UIImage(named: "cam_upload_logo_instagram")!
            case .facebook:
                return UIImage(named: "cam_upload_logo_facebook")!
            case .cameraRoll:
                return UIImage(named: "cam_upload_logo_camera_roll")!
            case .message:
                return UIImage(named: "cam_upload_logo_message")!
            case .mail:
                return UIImage(named: "cam_upload_logo_mail")!
            }
        }
    }
    
    func controller() -> ShareProtocol? {
        switch self {
        case .twitter:
            return ShareTwitter()
        case .instagram:
            return ShareInstagram()
        case .facebook:
            return ShareFacebook()
        case .cameraRoll:
            return ShareCameraRoll()
        case .message:
            return ShareMessage()
        case .mail:
            return ShareMail()
        }
    }
    
    func isInstalled() -> Bool {
        // Make sure when urls are added here they also get added to your Info.plist
        switch self {
        case .twitter:
            return UIApplication.shared.canOpenURL(URL(string: "twitter://")!)
        case .instagram:
            return UIApplication.shared.canOpenURL(URL(string: "instagram://")!)
        case .facebook:
            // Note: This URL is in the facebook documentation.
            return UIApplication.shared.canOpenURL(URL(string: "fbshareextension://")!)
        case .cameraRoll:
            return true
        case .message:
            return MFMessageComposeViewController.canSendText() && MFMessageComposeViewController.canSendAttachments()
        case .mail:
            return MFMailComposeViewController.canSendMail()
        }
    }
    
    var requiresAssetLocalIdentifier: Bool {
        get {
            switch self {
            case .twitter:
                return false
            case .instagram:
                return true
            case .facebook:
                return true
            case .cameraRoll:
                return false
            case .message:
                return false
            case .mail:
                return false
            }
        }
    }
    
    var supportsContentDescription: Bool {
        get {
            switch self {
            case .twitter:
                return true
            case .instagram:
                return false
            case .facebook:
                return false
            case .cameraRoll:
                return true // Is true so we can suppress the copied to clipboard alert since this is always done silently
            case .message:
                return true
            case .mail:
                return true
            }
        }
    }
}

protocol ShareProtocol: class {
    var controller: UIViewController! { get set }
    var contentDescription: String? { get set }
    var completion: ((Bool) -> Void)? { get set }
    var shareOption: ShareOption { get }
    
    var videoURL: URL? { get set }
    var imageURL: URL? { get set }
    var assetLocalIdentifier: String? { get set }
    
    func share()
}

class ShareManager {
    static func availableShareOptions(mediaType: MediaType) -> [ShareOption] {
        var shareOptions: [ShareOption]
        switch mediaType {
        case .image:
            shareOptions = [.cameraRoll, .message, .mail, .twitter, .facebook, .instagram]
        case .video:
            shareOptions = [.cameraRoll, .message, .mail, .facebook, .instagram]
        case .none:
            shareOptions = []
        }
        
        // Keep only options that are installed
        shareOptions = shareOptions.filter { $0.isInstalled() }
        
        return shareOptions
    }
    
    // Shares the provided image or video using the given share options.
    // Each option is chained together, after the first is completed the next one happens and so on.
    static func share(from controller: UIViewController!,
                      image: URL?,
                      video: URL?,
                      description: String?,
                      shareOptions: [ShareOption],
                      started: ((ShareOption) -> Void)? = nil,
                      completion: (() -> Void)? = nil,
                      finishedSavingAsset: (() -> Void)? = nil) {
        if shareOptions.count == 0 {
            completion?()
            return
        }
        
        var lastShareController: ShareProtocol? = nil
        var firstShareController: ShareProtocol? = nil
        
        if let _ = description,
            shareOptions.contains(where: { !$0.supportsContentDescription }) {
            // TODO: Notify them their description was copied to the pasteboard
            // The individual sharing controllers handle the actual copying to the pasteboard
            //StatusBar.show("Description copied to clipboard", action: nil)
        }
        
        var description = description
        description = description?.trimmingCharacters(in: .whitespaces)
        if description?.count == 0 { description = nil }
        
        let requiresAssetLocalIdentifier = shareOptions.contains { $0.requiresAssetLocalIdentifier }
        
        let work:(String?) -> Void = { assetLocalIdentifier in
            for option in shareOptions {
                if option == .cameraRoll && assetLocalIdentifier != nil { continue } // Don't do .cameraRoll again if we already did it earlier
                
                let shareController = option.controller()!
                shareController.controller = controller

                shareController.imageURL = image
                shareController.videoURL = video
                shareController.assetLocalIdentifier = assetLocalIdentifier

                shareController.contentDescription = description
                
                if let lastShareController = lastShareController {
                    lastShareController.completion = { success in
                        started?(shareController.shareOption)
                        shareController.share()
                    }
                }
                
                if firstShareController == nil { firstShareController = shareController }
                lastShareController = shareController
            }
            
            guard let lastShareController = lastShareController,
                let firstShareController = firstShareController else {
                    completion?()
                    return
            }
            
            lastShareController.completion = { success in
                completion?()
            }
            
            started?(firstShareController.shareOption)
            firstShareController.share()
        }
        
        if requiresAssetLocalIdentifier {
            let cameraRollShare = ShareCameraRoll()
            cameraRollShare.videoURL = video
            cameraRollShare.imageURL = image
            cameraRollShare.completion = { success in
                finishedSavingAsset?()
                work(cameraRollShare.assetLocalIdentifierResult)
            }
            cameraRollShare.share()
        }
        else {
            finishedSavingAsset?()
            work(nil)
        }
        
        
    }
}
