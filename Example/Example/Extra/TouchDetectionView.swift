//
//  TouchDetectionView.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 11/25/17.
//  Copyright © 2021 GottaYotta, Inc. All rights reserved.
//

import Foundation
import UIKit

protocol TouchDetectionViewDelegate: AnyObject {
    // Use this to detect touches anywhere in this view, including on buttons
    // Use cases for this are extremely rare, and normally you should be using a UIGestureRecognizer
    // Caution, don't rely on this being called only once per touch.
    func touchReceived(_ point: CGPoint, with event: UIEvent?)
}

class TouchDetectionView: UIView {
    weak var delegate: TouchDetectionViewDelegate?
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        self.delegate?.touchReceived(point, with: event)
        
        return super.hitTest(point, with: event)
    }
}
