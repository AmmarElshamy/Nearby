//
//  Location.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import Foundation
import CoreLocation

struct Location {
    let longitude: Double
    let latitude: Double
    
    init(_ location: CLLocation) {
        longitude = location.coordinate.longitude
        latitude = location.coordinate.latitude
    }
}
