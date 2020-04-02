//
//  SearchController.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 8/12/19.
//  Copyright © 2019 GottaYotta, Inc. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol SearchControllerDelegate: class {
    func searchController(_ searchController: SearchController, didSelectMapItem mapItem: MKMapItem)
}

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    weak var delegate: SearchControllerDelegate?
    
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var tableView: UITableView!
    
    private let searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKMapItem]()
    
    private var currentSearch: MKLocalSearch? {
        willSet {
            // Cancel the old search
            self.currentSearch?.cancel()
        }
    }
    
    private var boundingRegion: MKCoordinateRegion?
    
    private var locationManagerObserver: NSKeyValueObservation?
    
    init() {
        super.init(nibName: "SearchController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManagerObserver = LocationManager.shared.observe(\LocationManager.currentLocation) { [weak self] (_, _) in
            if let location = LocationManager.shared.currentLocation {
                // This sample only searches for nearby locations, defined by the device's location.
                let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 12_000, longitudinalMeters: 12_000)
                self?.boundingRegion = region
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.searchBar.becomeFirstResponder()
        
        self.search(queryString: "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        LocationManager.shared.requestLocation()
    }
    
    func search(queryString: String) {
        var queryString = queryString
        
        if queryString == "" {
            queryString = "Restaurants"
        }
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = queryString
        if let region = self.boundingRegion {
            searchRequest.region = region
        }
        
        self.currentSearch = MKLocalSearch(request: searchRequest)
        self.currentSearch?.start { [weak self] (response, error) in
            guard error == nil else {
                print("ERROR: Search failed \(String(describing: error))")
                return
            }
            
            if let results = response?.mapItems {
                self?.searchResults = results
            }
            else  {
                self?.searchResults = [MKMapItem]()
            }
            
            self?.tableView.reloadData()
        }
    }
    
    // MARK: UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.search(queryString: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: UITableViewDelegate and UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "identifier")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "identifier")
        }
        
        let result = self.searchResults[indexPath.row]
        
        cell!.textLabel?.text = result.name
        cell!.detailTextLabel?.text = result.placemark.formattedAddress
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = self.searchResults[indexPath.row]
        
        self.delegate?.searchController(self, didSelectMapItem: result)
        
        self.dismiss(animated: true, completion: nil)
    }
}
