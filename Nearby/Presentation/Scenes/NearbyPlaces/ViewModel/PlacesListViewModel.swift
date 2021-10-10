//
//  PlacesListViewModel.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import Foundation
import RxSwift
import RxRelay

class PlacesListViewModel {
    private let disposeBag = DisposeBag()
    let cellViewModels = BehaviorRelay<[PlaceCellViewModel]>(value: [])
    let placesUseCase: PlacesUseCase
    
    init(placesUseCase: PlacesUseCase, locationService: LocationService) {
        self.placesUseCase = placesUseCase
        
        placesUseCase.getPlaces(offset: 0, limit: 20, location: .init(.init(latitude: 37.79, longitude: -122.405))).observe(on: MainScheduler.instance).subscribe { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let paginationResult):
                
                switch paginationResult {
                case let .success(places, totalCount):
                    let models = places.map({ PlaceCellViewModel(place: $0) })
                    self.cellViewModels.accept(models)
                    
                case let .failure(errorMessage, statusCode):
                    print(errorMessage, statusCode)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
}
