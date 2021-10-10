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
    private let placesUseCase: PlacesUseCase
    
    private let disposeBag = DisposeBag()
    private let locationSubject = BehaviorRelay<Location?>(value: nil)
    let cellViewModels = BehaviorRelay<[PlaceCellViewModel]>(value: [])
    
    private var offset: Int {
        cellViewModels.value.count
    }
    private var totalCount = 0
    private var isPaginating = false
    
    init(placesUseCase: PlacesUseCase, locationService: LocationService) {
        self.placesUseCase = placesUseCase
        
        locationService.getCurrentLocation().subscribeOnUi { [weak self] location in
            if let currentLocation = self?.locationSubject.value,
               !currentLocation.isFar(from: location, distance: 500) {
                return
            }
            self?.locationSubject.accept(location)
            
        } onError: { error in
            print(error)
        }.disposed(by: disposeBag)

        onLocationDidChange()
    }
    
    private func onLocationDidChange() {
        locationSubject.skip(1).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.cellViewModels.accept([])
            self.fetchPlaces()
        }).disposed(by: disposeBag)
    }
    
    func fetchPlaces() {
        guard let location = locationSubject.value else { return }
        
        placesUseCase.getPlaces(offset: 0, limit: 20, location: location).observe(on: MainScheduler.instance).subscribe { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let paginationResult):
                
                switch paginationResult {
                case let .success(places, totalCount):
                    let models = places.map({ PlaceCellViewModel(place: $0) })
                    self.cellViewModels.accept(models)
                    self.totalCount = totalCount
                    
                    self.fetchPhotos(of: places)

                case let .failure(errorMessage, statusCode):
                    print(errorMessage, statusCode)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
    
    func fetchMorePlaces() {
        guard
            !isPaginating,
            offset < totalCount,
            let location = locationSubject.value
        else { return }
        
        isPaginating = true
        
        placesUseCase.getPlaces(offset: offset, limit: 20, location: location).observe(on: MainScheduler.instance).subscribe { [weak self] result in
            guard let self = self else { return }
            
            self.isPaginating = false
            
            switch result {
            case .success(let paginationResult):
                
                switch paginationResult {
                case let .success(places, totalCount):
                    var models = self.cellViewModels.value
                    let newModels = places.map({ PlaceCellViewModel(place: $0) })
                    models.append(contentsOf: newModels)
                    
                    self.cellViewModels.accept(models)
                    self.totalCount = totalCount
                    
                    self.fetchPhotos(of: places)
                    
                case let .failure(errorMessage, statusCode):
                    print(errorMessage, statusCode)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
    
    private func fetchPhotos(of places: [Place]) {
        places.forEach({
            fetchPlacePhoto(with: $0.id)
        })
    }
    
    private func fetchPlacePhoto(with id: String) {
        placesUseCase.getPlacePhoto(placeID: id).observe(on: MainScheduler.instance).subscribe { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(photo):
                var models = self.cellViewModels.value
                if let index = models.firstIndex(where: { $0.placeID == photo.placeID }) {
                    models[index].placePhoto = photo.photoURL
                    self.cellViewModels.accept(models)
                }
                
            case let .failure(errorMessage, statusCode):
                print(errorMessage, statusCode)
            }
            
        } onFailure: { error in
            print(error.localizedDescription)
        }.disposed(by: disposeBag)

    }
}
