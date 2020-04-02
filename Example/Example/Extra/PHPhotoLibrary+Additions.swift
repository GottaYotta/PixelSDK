//
//  PHPhotoLibrary+Additions.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 4/2/20.
//  Copyright © 2020 Foodworthy, Inc. All rights reserved.
//

import Foundation
import Photos

internal extension PHPhotoLibrary {
    enum AuthorizationStatus {
        case denied
        case restricted
        case authorized
        case unknown
    }
    
    class func authorize(completion: ((AuthorizationStatus) -> Void)?) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            completion?(.authorized)
        case .denied:
            completion?(.denied)
        case .restricted:
            completion?(.restricted)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                DispatchQueue.main.async {
                    switch status {
                    case .notDetermined:
                        completion?(.unknown) // Won't happen here probably
                    case .restricted:
                        completion?(.restricted)
                    case .denied:
                        completion?(.denied)
                    case .authorized:
                        completion?(.authorized)
                    @unknown default:
                        completion?(.unknown)
                    }
                }
            })
        @unknown default:
            completion?(.unknown)
        }
    }
}
