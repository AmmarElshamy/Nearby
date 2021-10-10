//
//  ApiClinet+Places.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import Foundation
import Alamofire
import RxSwift

enum FailureError: Error {
    case unKnownError
}

extension APIClient: PlacesApiService {
    func getPlaces(limit: Int, offset: Int, location: Location, radius: Int, date: String) -> Single<VenuesResult> {
        
        return Single<VenuesResult>.create { observer -> Disposable in
            let request = PlacesRequest(limit: limit, offset: offset, location: location, radius: radius, date: date)
            
            Alamofire.request(request).validate().responseJSON { response in
                switch response.result {
                case .success(_):
                    guard let data = response.data else {
                        observer(.failure(response.error ?? FailureError.unKnownError))
                        return
                    }
                    
                    do {
                        let result = try JSONDecoder().decode(VenuesResult.self, from: data)
                        observer(.success(result))
                    } catch {
                        observer(.failure(error))
                    }
                    
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            
            return Disposables.create {}
        }
    }
    
    func getPlacePhoto(placeID: String, date: String) -> Single<VenuePhotosResult> {
        
        return Single<VenuePhotosResult>.create { observer -> Disposable in
            let request = PlacePhotoRequest(placeID: placeID, date: date)
            
            Alamofire.request(request).validate().responseJSON { response in
                switch response.result {
                case .success(_):
                    guard let data = response.data else {
                        observer(.failure(response.error ?? FailureError.unKnownError))
                        return
                    }
                    
                    do {
                        let result = try JSONDecoder().decode(VenuePhotosResult.self, from: data)
                        observer(.success(result))
                    } catch {
                        observer(.failure(error))
                    }
                    
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            
            return Disposables.create {}
        }
        
    }
}
