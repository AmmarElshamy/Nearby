//
//  PlacesService.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import Foundation
import RxSwift

protocol PlacesApiService {
    func getPlaces(limit: Int, offset: Int, location: Location, radius: Int, date: String) -> Single<VenuesResult>
    func getPlacePhoto(placeID: String, date: String) -> Single<VenuePhotosResult>
}
