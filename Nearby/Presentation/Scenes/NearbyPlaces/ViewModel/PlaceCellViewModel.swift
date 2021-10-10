//
//  PlaceCellViewModel.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import Foundation

struct PlaceCellViewModel {
    let placeID: String
    let placeName: String
    let placeAddress: String
    var placePhoto: String? = nil
    
    init(place: Place) {
        placeID = place.id
        placeName = place.name
        placeAddress = place.address
    }
}
