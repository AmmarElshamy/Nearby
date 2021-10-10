//
//  LocationService.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import Foundation
import RxSwift
import CoreLocation

protocol LocationService {
    func getCurrentLocation() -> Observable<Location>
}

class LocationServiceImp: NSObject, LocationService {
    
    private let locationManager: LocationManager
    fileprivate let locationSubject = PublishSubject<Location>()
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        super.init()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    func getCurrentLocation() -> Observable<Location> {
        locationManager.startUpdatingLocation()
        return locationSubject.asObservable()
    }
}

extension LocationServiceImp: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        locationSubject.onNext(.init(location))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationSubject.onError(error)
    }
}
