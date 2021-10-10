//
//  Location.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import Foundation
import CoreLocation

struct Location {
    private let location: CLLocation
    
    var latitude: Double {
        location.coordinate.latitude
    }
    
    var longitude: Double {
        location.coordinate.longitude
    }
    
    init(_ location: CLLocation) {
        self.location = location
    }
    
    func isFar(from location: Location, distance: Double) -> Bool {
        self.location.distance(from: location.location) > distance
    }
}

extension Location {
    static var dummy: Location {
        .init(.init(latitude: 0, longitude: 0))
    }
}
