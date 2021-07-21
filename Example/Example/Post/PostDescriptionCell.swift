//
//  PostDescriptionCell.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 12/17/17.
//  Copyright © 2021 GottaYotta, Inc. All rights reserved.
//

import Foundation
import UIKit
import PixelSDK

class PostDescriptionCell: ExpandingTextViewCell {
    static let identifier = "PostDescriptionCellIdentifier"
    
    var session: Session! {
        didSet {
            self.descriptionTextView.text = self.session.userInfo?[DescriptionKey] as? String ?? ""
            
            if self.descriptionTextView.text.count == 0 {
                self.descriptionPlaceholderLabel.isHidden = false
            }
            else {
                self.descriptionPlaceholderLabel.isHidden = true
            }
        }
    }
    
    @IBOutlet var descriptionPlaceholderLabel: UILabel!
    
    @IBOutlet var dividerView: UIView!
    
    let maxDescriptionLength = 1200
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(ges:))))
        
        self.descriptionPlaceholderLabel.text = NSLocalizedString("Add a description", comment: "Text field to enter a description")
    }
    
    @objc func tapped(ges: UIGestureRecognizer) {
        self.descriptionTextView.becomeFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Prevent new lines when hitting the done button
        // Comment this out to easily test expanding the scrollview
        if text == "\n" {
            self.endEditing(true)
            return false
        }
        
        // Enforce max length
        let newLength = textView.text.count + text.count - range.length
        return (newLength > self.maxDescriptionLength) ? false : true
    }
    
    override func textViewDidChange(_ textView: UITextView) {
        super.textViewDidChange(textView)
        
        if textView.text.count == 0 {
            self.descriptionPlaceholderLabel.isHidden = false
        }
        else {
            self.descriptionPlaceholderLabel.isHidden = true
        }
        
        self.session.userInfo?[DescriptionKey] = textView.text
    }
    
    override func textViewDidBeginEditing(_ textView: UITextView) {
        super.textViewDidBeginEditing(textView)
    }
    
    override func textViewDidEndEditing(_ textView: UITextView) {
        super.textViewDidEndEditing(textView)
    }
}
