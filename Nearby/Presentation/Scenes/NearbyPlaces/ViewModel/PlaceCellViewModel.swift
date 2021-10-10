//
//  PlaceCellViewModel.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import Foundation

struct PlaceCellViewModel {
    let placeName: String
    let placeAddress: String
    
    init(place: Place) {
        placeName = place.name
        placeAddress = place.address
    }
}
