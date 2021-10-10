//
//  VenueResponseModel.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import Foundation

// MARK: - Result
struct VenuesResult: Decodable {
    let meta: VenuesMeta
    let response: VenuesResponse
}

// MARK: - Meta
struct VenuesMeta: Decodable {
    let code: Int
    let errorType, errorDetail: String?
}

// MARK: - Response
struct VenuesResponse: Decodable {
    let totalResults: Int
    let groups: [VenuesGroup]
}

// MARK: - Group
struct VenuesGroup: Decodable {
    let items: [VenuesGroupItem]
}

// MARK: - GroupItem
struct VenuesGroupItem: Decodable {
    let venue: Venue
}

// MARK: - Venue
struct Venue: Decodable {
    let id, name: String
    let location: VenueLocation
}

// MARK: - Location
struct VenueLocation: Decodable {
    let address: String
}


// Mapping
extension VenuesGroupItem {
    var mapped: Place {
        .init(id: venue.id, name: venue.name, address: venue.location.address)
    }
}
