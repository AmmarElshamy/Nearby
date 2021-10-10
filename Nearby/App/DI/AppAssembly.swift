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
        registerPreferencesManager(in: container)
        registerPlacesListViewModel(in: container)
    }
    
    private func handleLocationServiceRegistration(container: Container) {
        registerLocationManager(in: container)
        registerLocationService(in: container)
        
        func registerLocationManager(in container: Container) {
            container.register(LocationManager.self) { resolver in
                CLLocationManager()
            }.inObjectScope(.container)
        }
        
        func registerLocationService(in container: Container) {
            container.register(LocationService.self) { resolver in
                let locationManager = resolver.resolve(LocationManager.self)!
                return LocationServiceImp(locationManager: locationManager)
            }.inObjectScope(.container)
        }
    }
    
    private func registerPreferencesManager(in container: Container) {
        container.register(PreferencesManager.self) { _ in
            PreferencesManagerImp()
        }.inObjectScope(.container)
    }
    
    private func registerPlacesListViewModel(in container: Container) {
        container.register(PlacesListViewModel.self) { resolver in
            let locationService = resolver.resolve(LocationService.self)!
            let preferencesManager = resolver.resolve(PreferencesManager.self)!
            let placesUseCase = placesUseCaseImp(service: APIClient(), preferencesManager: preferencesManager)
            
            return PlacesListViewModel(placesUseCase: placesUseCase, locationService: locationService)
        }.inObjectScope(.transient)
    }
}
