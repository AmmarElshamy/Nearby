//
//  LocationManager.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import Foundation
import CoreLocation

protocol LocationManager: AnyObject {
    var delegate: CLLocationManagerDelegate? { get set }

    func requestWhenInUseAuthorization()
    func requestAlwaysAuthorization()
    func startUpdatingLocation()
}

extension CLLocationManager: LocationManager {}
