//
//  ExpandingTextViewCell.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 12/17/17.
//  Copyright © 2017 GottaYotta, Inc. All rights reserved.
//

import Foundation
import UIKit

protocol ExpandingTextViewCellDelegate: class {
    func didBeginEditingExpandingTextViewCell(controller: ExpandingTextViewCell)
    func didEndEditingExpandingTextViewCell(controller: ExpandingTextViewCell)
}

class ExpandingTextViewCell: UITableViewCell, UITextViewDelegate {
    weak var delegate: ExpandingTextViewCellDelegate?
    weak var tableView: UITableView!
    weak var controller: UIViewController!
    var topBarHeight: CGFloat = 0
    var bottomBarHeight: CGFloat = 0
    
    @IBOutlet var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.descriptionTextView.delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // Check if the height is going to change
        let newHeight = textView.sizeThatFits(CGSize(width: textView.bounds.size.width, height: CGFloat.greatestFiniteMagnitude)).height
        if newHeight != textView.bounds.size.height {
            // Disable animation to prevent weird jittering
            UIView.animate(withDuration: 0, animations: {
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            }, completion: { (success) in
                self.updateScrollOffset(animated: false)
            })
        }
        else {
            self.updateScrollOffset(animated: false)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.delegate?.didBeginEditingExpandingTextViewCell(controller: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.updateScrollOffset(animated: true)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.delegate?.didEndEditingExpandingTextViewCell(controller: self)
    }
    
    func updateScrollOffset(animated: Bool) {
        guard let selectedRange = self.descriptionTextView.selectedTextRange else { return }
        
        let caretRect = self.descriptionTextView.convert(self.descriptionTextView.caretRect(for: selectedRange.start), to: self.controller.view)
        if !caretRect.origin.x.isFinite || !caretRect.origin.y.isFinite || !caretRect.size.width.isFinite || !caretRect.size.height.isFinite || caretRect.size.width == 0 || caretRect.size.height == 0 { return }
        
        let keyboardHeight = (UIApplication.shared.delegate as! AppDelegate).keyboardHeight
        
        let lowerCaretPoint = CGPoint(x: caretRect.origin.x, y: caretRect.origin.y+caretRect.size.height)
        let upperCaretPoint = caretRect.origin
        
        let visibleHeight = self.controller.view.bounds.size.height-(keyboardHeight-self.bottomBarHeight)
        
        if lowerCaretPoint.y > visibleHeight {
            // Caret is behind keyboard
            
            // Figure out how far below it is from the top of the keyboard
            var offset = lowerCaretPoint.y - visibleHeight
            
            // Add in a little bit of padding
            offset += 12
            
            // Shift the content that far up so it becomes visible
            var newContentOffset = self.tableView.contentOffset
            newContentOffset.y += offset
            
            //print("Old Offset: \(self.tableView.contentOffset) New Offset: \(newContentOffset)")
            
            // Not exactly sure why I need this to be done later
            // I suspect its because of the beginUpdates() endUpdates() calls above
            self.tableView.setContentOffset(newContentOffset, animated: animated)
        }
        else if upperCaretPoint.y < self.topBarHeight {
            // Caret is above the top of the screen
            
            // Figure out how far above it is from the bottom of the nav bar
            var offset = self.topBarHeight - upperCaretPoint.y
            
            // Add in a little bit of padding
            offset += 12
            
            // Shift the content that far down so it becomes visible
            var newContentOffset = self.tableView.contentOffset
            newContentOffset.y -= offset
            
            //print("Old Offset: \(self.tableView.contentOffset) New Offset: \(newContentOffset)")
            
            self.tableView.setContentOffset(newContentOffset, animated: animated)
        }
    }
}
