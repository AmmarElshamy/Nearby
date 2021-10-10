//
//  PlacesRequest.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import Foundation
import Alamofire

struct PlacesRequest: URLRequestBuilder {
    let path: String
    let parameters: Parameters? = nil
    let method: HTTPMethod = .get
    
    init(limit: Int, offset: Int, location: Location, radius: Int, date: String) {
        path = "/explore?client_id=\(DataConstants.clientID)&client_secret=\(DataConstants.clientSecret)&v=\(date)&ll=\(location.latitude),\(location.longitude)&radius=\(radius)&query=steak&limit=\(limit)&offset=\(offset)&price=2,3"
    }
}

struct PlacePhotoRequest: URLRequestBuilder {
    let path: String
    let parameters: Parameters? = nil
    let method: HTTPMethod = .get
    
    init(placeID: String, date: String) {
        path = "/\(placeID)/photos?client_id=\(DataConstants.clientID)&client_secret=\(DataConstants.clientSecret)&v=\(date)&group=venue&limit=1"
    }
}
