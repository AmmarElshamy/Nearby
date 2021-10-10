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
}

struct placesUseCaseImp: PlacesUseCase {
    private let service: PlacesApiService
    
    init(service: PlacesApiService) {
        self.service = service
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
    
    func getPlacePhoto(placeID: String) -> Single<AppResult<String>> {
        let date = DateManager.getCurrentDate()
        
        return service.getPlacePhoto(placeID: placeID, date: date).map { result in
            if result.meta.code == .success,
               let urlString = result.response.photos.items.first?.mapped {
                return .success(data: urlString)
            } else {
                return .failure(errorMessage: .somethingWentWrong, statusCode: result.meta.code)
            }
        }
    }
}
