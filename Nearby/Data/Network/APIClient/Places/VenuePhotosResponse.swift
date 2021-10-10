//
//  VenuePhotosResponse.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import Foundation

// MARK: - Result
struct VenuePhotosResult: Codable {
    let meta: VenuePhotosMeta
    let response: VenuePhotosResponse
}

// MARK: - Meta
struct VenuePhotosMeta: Codable {
    let code: Int
    let errorType, errorDetail: String?
}

// MARK: - Response
struct VenuePhotosResponse: Codable {
    let photos: VenuePhotos
}

// MARK: - Photos
struct VenuePhotos: Codable {
    let count: Int
    let items: [VenuePhotosItem]
}

// MARK: - Item
struct VenuePhotosItem: Codable {
    let id: String
    let prefix, suffix: String
    let width, height: Int
}

// Mapping
extension VenuePhotosItem {
    var mapped: String {
        "\(prefix)\(width)x\(height)\(suffix)"
    }
}
