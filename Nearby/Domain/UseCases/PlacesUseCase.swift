//
//  PlacesUseCase.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import Foundation
import RxSwift

protocol PlacesUseCase {
    func getPlaces(offset: Int, limit: Int, location: Location) -> Single<PaginationResult<[Place]>>
    func getPlacePhoto(placeID: String) -> Single<AppResult<PlacePhoto>>
    func set(mode: String)
    func getSavedMode() -> String?
}

struct placesUseCaseImp: PlacesUseCase {
    private let service: PlacesApiService
    private let preferencesManager: PreferencesManager
    
    init(service: PlacesApiService, preferencesManager: PreferencesManager) {
        self.service = service
        self.preferencesManager = preferencesManager
    }
    
    func getPlaces(offset: Int, limit: Int, location: Location) -> Single<PaginationResult<[Place]>> {
        let radius = 1000
        let date = DateManager.getCurrentDate()
        
        return service.getPlaces(limit: limit, offset: offset, location: location, radius: radius, date: date).map { result in
            if result.meta.code == .success,
               let data = result.response.groups.first?.items.map({ $0.mapped }) {
                return .success(data: data, totalCount: result.response.totalResults)
            } else {
                return .failure(errorMessage: .somethingWentWrong, statusCode: result.meta.code)
            }
        }
    }
    
    func getPlacePhoto(placeID: String) -> Single<AppResult<PlacePhoto>> {
        let date = DateManager.getCurrentDate()
        
        return service.getPlacePhoto(placeID: placeID, date: date).map { result in
            if result.meta.code == .success,
               let photo = result.response.photos.items.first?.mapped {
                return .success(data: .init(placeID: placeID, photoURL: photo))
            } else {
                return .failure(errorMessage: .somethingWentWrong, statusCode: result.meta.code)
            }
        }
    }
    
    func getSavedMode() -> String? {
        preferencesManager.getMode()
    }
    
    func set(mode: String) {
        preferencesManager.set(mode: mode)
    }
}
