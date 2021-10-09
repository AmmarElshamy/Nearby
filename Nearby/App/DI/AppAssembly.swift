//
//  AppAssembly.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import Foundation
import Swinject
import CoreLocation

class AppAssembly: Assembly {
    func assemble(container: Container) {
        handleLocationServiceRegistration(container: container)
    }
}

// MARK: LocationService
extension AppAssembly {
    private func handleLocationServiceRegistration(container: Container) {
        registerLocationManager(in: container)
        registerLocationService(in: container)
    }
    
    private func registerLocationManager(in container: Container) {
        container.register(LocationManager.self) { resolver in
            CLLocationManager()
        }
    }
    
    private func registerLocationService(in container: Container) {
        container.register(LocationService.self) { resolver in
            let locationManager = resolver.resolve(LocationManager.self)!
            return LocationServiceImp(locationManager: locationManager)
        }
    }
}
