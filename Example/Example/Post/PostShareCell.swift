//
//  PostShareCell.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 12/17/17.
//  Copyright © 2021 GottaYotta, Inc. All rights reserved.
//

import Foundation
import UIKit

protocol PostShareCellDelegate: AnyObject {
    func postShareCell(_ cell: PostShareCell, didTapShareAtIndexPath indexPath: IndexPath)
}

class PostShareCell: UITableViewCell {
    static let identifier = "PostShareCellIdentifier"
    
    weak var delegate: PostShareCellDelegate?
    var indexPath: IndexPath!
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var checkImageView: UIImageView!
    @IBOutlet var checkBackgroundView: UIView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(ges:))))
        
        self.checkBackgroundView.layer.cornerRadius = 22/2
        
    }
    
    @objc func tapped(ges: UIGestureRecognizer) {
        self.delegate?.postShareCell(self, didTapShareAtIndexPath: self.indexPath)
    }
}
