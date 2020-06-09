//
//  PostController.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 2/12/18.
//  Copyright © 2018 GottaYotta, Inc. All rights reserved.
//

import Foundation
import UIKit
import PixelSDK
import RPCircularProgress

let LocationNameKey = "location_name"
let DescriptionKey = "description"

let UserDefaultsSelectedShareOptionsKey = "PXUserDefaultsPostControllerSelectedShareOptions"

let colorScheme = UIColor(named: "Pixel SDK Theme Color")!

class PostController: UIViewController {
    
    var session: Session!
    
    @IBOutlet private var navBarView: UIView!
    @IBOutlet private var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var titleLabel: UILabel!
    
    @IBOutlet private var uploadPostButtonContainer: UIView!
    @IBOutlet private var uploadPostButton: UIButton!
    
    @IBOutlet private var tableView: UITableView!
    
    private var safeAreaInsets: UIEdgeInsets {
        var safeAreaInsets = self.view.safeAreaInsets
        if safeAreaInsets.top <= 0 {
            safeAreaInsets.top = 5
        }
        return safeAreaInsets
    }
    private var minNavBarHeight: CGFloat {
        return 51 + self.safeAreaInsets.top
    }
    private var maxNavBarHeight: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return UIScreen.main.bounds.height*6/15
        }
        else {
            return 223 + self.safeAreaInsets.top
        }
    }
    
    private var previewController = PreviewController()
    
    private var mediaPreviewLeftConstraint: NSLayoutConstraint?
    private var mediaPreviewRightConstraint: NSLayoutConstraint?
    private var mediaPreviewTopConstraint: NSLayoutConstraint?
    private var mediaPreviewBottomConstraint: NSLayoutConstraint?
    
    private var tagLocationCell: PostTagLocationCell!
    private var descriptionCell: PostDescriptionCell!
    private var isEditingDescription = false
    
    private var availableShareOptions: [ShareOption]!
    private var selectedShareOptions = [ShareOption : Bool]()
    private var activeShareOption: ShareOption?
    
    init() {
        super.init(nibName: "PostController", bundle: Bundle.main)
        
        self.restoreShareOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.session.userInfo == nil {
            self.session.userInfo = [:]
        }
        
        self.availableShareOptions = ShareManager.availableShareOptions(mediaType: self.session!.mediaType)
        
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.tableView.register(UINib.init(nibName: "PostShareCell", bundle: Bundle.main), forCellReuseIdentifier: PostShareCell.identifier)
        
        // Add the PreviewController as a view
        self.movePreviewToBackground(animated: false)
        
        // Display the session in the PreviewController
        self.previewController.session = self.session
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(movePreviewToForegroundAnimated))
        self.navBarView.addGestureRecognizer(tap)
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(movePreviewToForegroundAnimated))
        swipe.direction = .down
        self.navBarView.addGestureRecognizer(swipe)
        
        self.uploadPostButton.backgroundColor = colorScheme
        self.uploadPostButtonContainer.layer.cornerRadius = 4
        self.uploadPostButtonContainer.layer.masksToBounds = true
        
        if let view = self.view as? TouchDetectionView {
            view.delegate = self
        }
        
        self.uploadPostButton.setTitle(NSLocalizedString("Share post", comment: "Share photo or video button"), for: .normal)
        self.titleLabel.text = NSLocalizedString("Share", comment: "Share Title")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.updateLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        self.updateLayout()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // If we switch from light to dark mode, update the CG colors in the tableview.
        self.tableView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Handle rotation on iPad
        self.updateLayout()
    }
    
    @IBAction func back() {
        VideoExporter.shared.cancelExport()
        
        self.navigationController?.popViewController(animated: false)
    }
    
    // MARK: Uploading
    
    @IBAction func upload() {
        if let video = self.session.video {
            print("Beginning video export")
            
            let (progressAlertController, circularProgress) = self.displayProgressAlertController()
            
            VideoExporter.shared.export(video: video, progress: { progress in
                print("Export Progress: \(progress)")
                
                circularProgress.updateProgress(CGFloat(progress), initialDelay: 0, duration: 0.01)
                
            }, completion: { (error) in
                
                progressAlertController.dismiss(animated: true, completion: nil)
                
                if let error = error {
                    print("Unable to export video: \(error)")
                    return
                }
                
                print("Finished video export to file: \(video.exportedVideoURL)")
                
                
                // YOUR VIDEO UPLOAD LOGIC GOES HERE
                
                
                self.share(completion: {
                    self.dismiss(animated: true, completion: nil)
                    
                    // Remove the session from the users drafts after sharing completes
                    self.session.destroy()
                })
            })
        }
        else if let image = self.session.image {
            print("Beginning image export")
            
            ImageExporter.shared.export(image: image, completion: { (error, uiImage) in
                if let error = error {
                    print("Unable to export image: \(error)")
                    return
                }
                
                print("Finished image export: \(uiImage!) and to file: \(image.exportedImageURL)")
                
                
                // YOUR IMAGE UPLOAD LOGIC GOES HERE
                
                
                self.share(completion: {
                    self.dismiss(animated: true, completion: nil)
                    
                    // Remove the session from the users drafts after sharing completes
                    self.session.destroy()
                })
            })
        }
        
    }
    
    // MARK: Progress Alert
    
    func displayProgressAlertController() -> (UIAlertController, RPCircularProgress) {
        let controller = UIAlertController(title: "Preparing...", message: "\n\n\n", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            VideoExporter.shared.cancelExport()
            controller.dismiss(animated: true, completion: nil)
        }))
        
        let progress = RPCircularProgress()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.roundedCorners = false
        progress.thicknessRatio = 0.3
        progress.progressTintColor = colorScheme
        
        controller.view.addSubview(progress)
        progress.widthAnchor.constraint(equalToConstant: 50).isActive = true
        progress.heightAnchor.constraint(equalToConstant: 50).isActive = true
        progress.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor).isActive = true
        progress.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor).isActive = true
        
        self.present(controller, animated: true, completion: nil)
        
        return (controller, progress)
    }
    
    // MARK: Sharing To Other Apps
    
    func share(completion: @escaping () -> Void) {
        // Get an ordered array of the selected share options
        let selectedOptions = self.availableShareOptions.filter({ self.selectedShareOptions[$0] == true })
        
        if selectedOptions.count == 0 {
            completion()
            return
        }
        
        var image: SessionImage? = nil
        var video: SessionVideo? = nil
        
        if let aImage = self.session.image {
            guard aImage.isExported else {
                print("WARNING: Tried to share image before export was done")
                return
            }
            image = aImage
        }
        else if let aVideo = self.session.video {
            guard aVideo.isExported else {
                print("WARNING: Tried to share video before export was done")
                return
            }
            video = aVideo
        }
        
        ShareManager.share(from: self,
                           image: image?.exportedImageURL,
                           video: video?.exportedVideoURL,
                           description: self.session!.userInfo?[DescriptionKey] as? String,
                           shareOptions: selectedOptions,
                           started: { shareOption in
                            self.activeShareOption = shareOption
                            
                            UIView.performWithoutAnimation {
                                // Reload share section to reflect active share option
                                self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
                            }
        },
                           completion: {
                            self.activeShareOption = nil
                            
                            UIView.performWithoutAnimation {
                                // Reload share section to reflect active share option
                                self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
                            }
                            completion()
        })
        
        // Scroll to bottom so they can see all share option loading indicators in the event some share cells are hidden
        let lastSection = self.numberOfSections(in: self.tableView)-1
        let lastRow = self.tableView(self.tableView, numberOfRowsInSection: lastSection)-1
        self.tableView.scrollToRow(at: IndexPath(row: lastRow, section: lastSection), at: .bottom, animated: true)
    }
    
    // MARK: Layout Update Logic
    
    func updateLayout() {
        self.navBarView.layoutMargins =  UIEdgeInsets(top: self.safeAreaInsets.top, left: 0, bottom: 0, right: 0)
        
        if self.isEditingDescription {
            let keyboardHeight = (UIApplication.shared.delegate as! AppDelegate).keyboardHeight
            self.tableView.contentInset = UIEdgeInsets(top: self.maxNavBarHeight, left: 0, bottom: keyboardHeight, right: 0)
        }
        else {
            self.tableView.contentInset = UIEdgeInsets(top: self.maxNavBarHeight, left: 0, bottom: self.safeAreaInsets.bottom+77, right: 0)
        }
        self.tableView.scrollIndicatorInsets = UIEdgeInsets(top: self.maxNavBarHeight, left: 0, bottom: self.safeAreaInsets.bottom, right: 0)
        
        self.updateNavBarHeightConstraint()
    }
    
    func updateNavBarHeightConstraint() {
        if self.tableView.contentOffset.y <= -self.minNavBarHeight {
            self.navBarHeightConstraint.constant = abs(self.tableView.contentOffset.y)
        }
        else {
            self.navBarHeightConstraint.constant = self.minNavBarHeight
        }
    }
    
    // MARK: Preview Controller Foreground/Background Switching
    
    @objc func movePreviewToForegroundAnimated() {
        self.movePreviewToForeground(animated: true)
    }
    
    func movePreviewToForeground(animated: Bool) {
        if self.view.window != nil {
            self.view.layoutIfNeeded()
        }
        
        self.previewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(self.previewController)
        self.view.addSubview(self.previewController.view)
        
        self.mediaPreviewLeftConstraint?.isActive = false
        self.mediaPreviewRightConstraint?.isActive = false
        self.mediaPreviewTopConstraint?.isActive = false
        self.mediaPreviewBottomConstraint?.isActive = false
        
        self.mediaPreviewLeftConstraint = self.previewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        self.mediaPreviewRightConstraint = self.previewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        self.mediaPreviewTopConstraint = self.previewController.view.topAnchor.constraint(equalTo: self.view.topAnchor)
        self.mediaPreviewBottomConstraint = self.previewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        self.mediaPreviewLeftConstraint?.isActive = true
        self.mediaPreviewRightConstraint?.isActive = true
        self.mediaPreviewTopConstraint?.isActive = true
        self.mediaPreviewBottomConstraint?.isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(movePreviewToBackgroundAnimated))
        self.previewController.view.addGestureRecognizer(tap)
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(movePreviewToBackgroundAnimated))
        swipe.direction = [.up, .down]
        self.previewController.view.addGestureRecognizer(swipe)
        
        let layoutWork = {
            self.previewController.contentMode = .contentAspectFit
            
            if #available(iOS 13.0, *) {
                self.previewController.view.backgroundColor = .systemBackground
            } else {
                self.previewController.view.backgroundColor = .white
            }
            if self.view.window != nil {
                self.view.layoutIfNeeded()
            }
        }
        
        if animated {
            UIView.animate(withDuration: 0.15) {
                layoutWork()
            }
        }
        else {
            layoutWork()
        }
    }
    
    @objc func movePreviewToBackgroundAnimated() {
        self.movePreviewToBackground(animated: true)
    }
    
    func movePreviewToBackground(animated: Bool) {
        if self.view.window != nil {
            self.view.layoutIfNeeded()
        }
        
        self.previewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(self.previewController)
        self.navBarView.addSubview(self.previewController.view)
        self.navBarView.sendSubviewToBack(self.previewController.view)
        
        self.mediaPreviewLeftConstraint?.isActive = false
        self.mediaPreviewRightConstraint?.isActive = false
        self.mediaPreviewTopConstraint?.isActive = false
        self.mediaPreviewBottomConstraint?.isActive = false
        
        self.mediaPreviewLeftConstraint = self.previewController.view.leftAnchor.constraint(equalTo: self.navBarView.leftAnchor)
        self.mediaPreviewRightConstraint = self.previewController.view.rightAnchor.constraint(equalTo: self.navBarView.rightAnchor)
        self.mediaPreviewTopConstraint = self.previewController.view.topAnchor.constraint(equalTo: self.navBarView.topAnchor)
        self.mediaPreviewBottomConstraint = self.previewController.view.bottomAnchor.constraint(equalTo: self.navBarView.bottomAnchor)
        
        self.mediaPreviewLeftConstraint?.isActive = true
        self.mediaPreviewRightConstraint?.isActive = true
        self.mediaPreviewTopConstraint?.isActive = true
        self.mediaPreviewBottomConstraint?.isActive = true
        
        for ges in self.previewController.view.gestureRecognizers ?? [UIGestureRecognizer]() {
            self.previewController.view.removeGestureRecognizer(ges)
        }
        
        let layoutWork = {
            self.previewController.contentMode = .contentAspectFill
            
            self.previewController.view.backgroundColor = UIColor.clear
            if self.view.window != nil {
                self.view.layoutIfNeeded()
            }
        }
        
        if animated {
            UIView.animate(withDuration: 0.15) {
                layoutWork()
            }
        }
        else {
            layoutWork()
        }
    }
    
}

// MARK: - UITableViewDelegate/DataSource
extension PostController: UITableViewDataSource, UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateNavBarHeightConstraint()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 { // Tag Location
                return 54
            }
            else { // Description
                return UITableView.automaticDimension
            }
        }
        else { // Share cells
            if UIScreen.main.bounds.size.height <= 667 { //iPhone 6 and smaller
                return 43.5
            }
            else {
                return 44
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 1 {
            if self.descriptionCell != nil {
                // This fixes a weird jumping bug that occurs whenever there is a lot of text
                // in the text view and you reload a section/row e.g. by selecting a share option.
                return self.descriptionCell.contentView.sizeThatFits(CGSize(width: self.tableView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height
            }
            else {
                return 120
            }
        }
        else {
            return self.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2 // Tag location and description cells
        }
        else {  // Share cells
            return self.availableShareOptions.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 { // Tag Location cell
                if self.tagLocationCell == nil {
                    // Load this cell only once
                    self.tagLocationCell = (NSObject.load(fromNib: "PostTagLocationCell", bundle: Bundle.main, classToLoad: PostTagLocationCell.self) as! PostTagLocationCell)
                    self.tagLocationCell.controller = self
                }
                
                self.tagLocationCell.session = self.session
                
                return self.tagLocationCell
            }
            else { // Add a description cell
                if self.descriptionCell == nil {
                    // Load this cell only once
                    self.descriptionCell = (NSObject.load(fromNib: "PostDescriptionCell", bundle: Bundle.main, classToLoad: PostDescriptionCell.self) as! PostDescriptionCell)
                    self.descriptionCell.delegate = self
                    self.descriptionCell.tableView = self.tableView
                    self.descriptionCell.controller = self
                }
                
                self.descriptionCell.session = self.session
                self.descriptionCell.topBarHeight = self.minNavBarHeight
                
                return self.descriptionCell
            }
        }
        else {// Share cell
            let cell = tableView.dequeueReusableCell(withIdentifier: PostShareCell.identifier, for: indexPath) as! PostShareCell
            cell.delegate = self
            cell.indexPath = indexPath
            
            let shareOption = self.availableShareOptions[indexPath.row]
            
            cell.logoImageView.image = shareOption.smallLogoImage
            cell.nameLabel.text = shareOption.displayName
            
            if self.activeShareOption == shareOption {
                cell.checkImageView.isHidden = true
                cell.checkBackgroundView.isHidden = true
                cell.activityIndicatorView.isHidden = false
                cell.activityIndicatorView.startAnimating()
            }
            else {
                cell.activityIndicatorView.isHidden = true
                
                if let isSelected = self.selectedShareOptions[shareOption],
                    isSelected {
                    cell.checkImageView.isHidden = false
                    cell.checkBackgroundView.isHidden = false
                    
                    cell.checkBackgroundView.backgroundColor = colorScheme
                    
                    cell.checkBackgroundView.layer.borderWidth = 0
                }
                else {
                    cell.checkImageView.isHidden = true
                    cell.checkBackgroundView.isHidden = false
                    
                    if #available(iOS 13.0, *) {
                        cell.checkBackgroundView.backgroundColor = .systemGray6
                        cell.checkBackgroundView.layer.borderColor = UIColor.systemGray5.cgColor
                    } else {
                        cell.checkBackgroundView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/155, alpha: 1)
                        cell.checkBackgroundView.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 234/155, alpha: 1).cgColor
                    }
                    
                    cell.checkBackgroundView.layer.borderWidth = 3
                }
            }
            
            if #available(iOS 13.0, *) {
                cell.nameLabel.textColor = .label
            } else {
                cell.nameLabel.textColor = UIColor(white: 30/255, alpha: 1)
            }
            
            return cell
        }
    }
}

// MARK: - ExpandingTextViewCellDelegate
extension PostController: ExpandingTextViewCellDelegate {
    
    func didBeginEditingExpandingTextViewCell(controller: ExpandingTextViewCell) {
        self.isEditingDescription = true
        
        self.updateLayout()
    }
    
    func didEndEditingExpandingTextViewCell(controller: ExpandingTextViewCell){
        self.isEditingDescription = false
        
        self.updateLayout()
    }
}

// MARK: - PostShareCellDelegate
extension PostController: PostShareCellDelegate {
    
    func postShareCell(_ cell: PostShareCell, didTapShareAtIndexPath indexPath: IndexPath) {
        let shareOption = self.availableShareOptions[indexPath.row]
        
        if let isSelected = self.selectedShareOptions[shareOption] {
            self.selectedShareOptions[shareOption] = !isSelected
        }
        else {
            self.selectedShareOptions[shareOption] = true
        }
        
        // This fixes a weird jumping animation
        UIView.performWithoutAnimation {
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        self.saveShareOptions()
    }
    
    func saveShareOptions() {
        // Convert it to a normal dictionary so we can save to defaults
        var selectedShareOptions = [String : Bool]()
        for (key, value) in self.selectedShareOptions {
            selectedShareOptions[key.rawValue] = value
        }
        
        // Save to defaults
        UserDefaults.standard.set(selectedShareOptions, forKey: UserDefaultsSelectedShareOptionsKey)
    }
    
    func restoreShareOptions() {
        // Restore the previously selected share options
        let selectedShareOptions = UserDefaults.standard.dictionary(forKey: UserDefaultsSelectedShareOptionsKey) as? [String : Bool] ?? [String : Bool]()
        
        // Convert it to our dictionary with enums for keys
        for (key, value) in selectedShareOptions {
            if let shareOption = ShareOption(rawValue: key) {
                self.selectedShareOptions[shareOption] = value
            }
        }
    }
}

// MARK: - TouchDetectionViewDelegate

extension PostController: TouchDetectionViewDelegate {
    
    func touchReceived(_ point: CGPoint, with event: UIEvent?) {
        if self.descriptionCell == nil { return }
        
        // End editing if the touch was not inside the description cell
        if(!self.descriptionCell.point(inside: self.view.convert(point, to: self.descriptionCell), with: event)) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.view.endEditing(true)
            }
        }
    }
}
