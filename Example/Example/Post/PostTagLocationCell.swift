//
//  PostTagLocationCell.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 12/17/17.
//  Copyright © 2017 GottaYotta, Inc. All rights reserved.
//

import Foundation
import UIKit
import PixelSDK
import MapKit

class PostTagLocationCell: UITableViewCell, SearchControllerDelegate {
    
    static let identifier = "PostTagLocationCellIdentifier"
    
    weak var controller: UIViewController?
    var session: Session! {
        didSet {
            if self.session == nil {
                return
            }
            self.updateUI()
        }
    }
    
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var pinImageView: UIImageView!
    @IBOutlet private var crossButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(search)))
    }
    
    func updateUI() {
        if let name = self.session.userInfo?[LocationNameKey] as? String {
            self.locationLabel.text = name
            if #available(iOS 13.0, *) {
                self.locationLabel.textColor = .label
                self.pinImageView.tintColor = .label
            } else {
                self.locationLabel.textColor = UIColor(white: 30/255, alpha: 1)
                self.pinImageView.tintColor = UIColor(white: 30/255, alpha: 1)
            }
            
            self.crossButton.isUserInteractionEnabled = true
            self.pinImageView.image = UIImage(named: "cam_upload_cross")
        }
        else {
            self.locationLabel.text = "Tag a location"
            if #available(iOS 13, *) {
                self.locationLabel.textColor = .placeholderText
                self.pinImageView.tintColor = .placeholderText
            } else {
                self.locationLabel.textColor = UIColor(white: 190/255, alpha: 1)
                self.pinImageView.tintColor = UIColor(white: 190/255, alpha: 1)
            }
            
            self.crossButton.isUserInteractionEnabled = false
            self.pinImageView.image = UIImage(named: "cam_upload_pin")
        }
    }
    
    @objc func search() {
        let searchController = SearchController()
        searchController.delegate = self
        self.controller?.present(searchController, animated: true, completion: nil)
    }
    
    @IBAction func cross() {
        self.session.userInfo?[LocationNameKey] = nil
        
        self.updateUI()
    }
    
    // MARK: SearchControllerDelegate
    
    func searchController(_ searchController: SearchController, didSelectMapItem mapItem: MKMapItem) {
        self.session.userInfo?[LocationNameKey]  = mapItem.name
        
        self.updateUI()
    }
}
