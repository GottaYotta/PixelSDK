//
//  MKPlacemark+Additions.swift
//  PixelSDKExample
//
//  Created by Josh Bernfeld on 8/12/19.
//  Copyright © 2019 GottaYotta, Inc. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Contacts

extension MKPlacemark {
    var formattedAddress: String? {
        guard let postalAddress = postalAddress else { return nil }
        return CNPostalAddressFormatter.string(from: postalAddress, style: .mailingAddress).replacingOccurrences(of: "\n", with: " ")
    }
}
