//
//  PlacesViewModelTests.swift
//  NearbyTests
//
//  Created by Ammar Elshamy on 11/10/2021.
//

import XCTest
import RxSwift
@testable import Nearby

class PlacesViewModelTests: XCTestCase {
    
    var sut: PlacesListViewModel!
    let locationService = MockLocationService()
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testState_whenFetchingData_isLoading() {
        sut = .init(placesUseCase: MockDelayedPlacesUseCase(), locationService: locationService)
        XCTAssertEqual(sut.viewState.value, .loading)
    }
    
    func testState_whenEmptyData_isEmpty() {
        sut = .init(placesUseCase: MockEmptyPlacesUseCase(), locationService: locationService)
        locationService.subject.onNext(.init(.init(latitude: 0, longitude: 0)))
        
        let expectation = expectation(description: "")
        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        
        if result == .timedOut {
            XCTAssertEqual(sut.viewState.value, .empty)
        }
    }
    
    func testState_whenErrorInFetching_isError() {
        sut = .init(placesUseCase: MockErrorPlacesUseCase(), locationService: locationService)
        locationService.subject.onNext(.init(.init(latitude: 0, longitude: 0)))

        let expectation = expectation(description: "")
        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        
        if result == .timedOut {
            XCTAssertEqual(sut.viewState.value, .error)
        }
    }
    
    func testState_whenSuccessWithData_isNormal() {
        sut = .init(placesUseCase: MockOneResultPlacesUseCase(), locationService: locationService)
        locationService.subject.onNext(.init(.init(latitude: 0, longitude: 0)))

        let expectation = expectation(description: "")
        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        
        if result == .timedOut {
            XCTAssertEqual(sut.viewState.value, .normal)
        }
    }
    
    func testState_whenLocationError_isError() {
        sut = .init(placesUseCase: MockOneResultPlacesUseCase(), locationService: locationService)
        locationService.subject.onError(LocationError.unKnownError)

        let expectation = expectation(description: "")
        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        
        if result == .timedOut {
            XCTAssertEqual(sut.viewState.value, .error)
        }
    }
    
    func testMode_whenButtonTapped_changes() {
        sut = .init(placesUseCase: MockEmptyPlacesUseCase(), locationService: locationService)
        locationService.subject.onNext(.init(.init(latitude: 0, longitude: 0)))

        let initialMode = sut.mode.value
        sut.modeButtonSubject.accept(())
        let currentMode = sut.mode.value
        
        XCTAssertNotEqual(initialMode, currentMode)
    }
    
    func testCellModels_inCaseNoData_containsNoItems() {
        sut = .init(placesUseCase: MockEmptyPlacesUseCase(), locationService: locationService)
        locationService.subject.onNext(.init(.init(latitude: 0, longitude: 0)))
        
        let expectation = expectation(description: "")
        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        
        if result == .timedOut {
            XCTAssert(sut.cellViewModels.value.count == 0)
        }
    }
    
    func testCellModels_whenGetOneItem_containsOneItem() {
        sut = .init(placesUseCase: MockOneResultPlacesUseCase(), locationService: locationService)
        locationService.subject.onNext(.init(.init(latitude: 0, longitude: 0)))
        
        let expectation = expectation(description: "")
        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        
        if result == .timedOut {
            XCTAssert(sut.cellViewModels.value.count == 1)
        }
    }
}

// MARK:- Mocks

class MockDelayedPlacesUseCase: PlacesUseCase {
    func getPlaces(offset: Int, limit: Int, location: Location) -> Single<PaginationResult<[Place]>> {
        .just(.success(data: [], totalCount: 0)).delaySubscription(.seconds(5), scheduler: SerialDispatchQueueScheduler.init(internalSerialQueueName: ""))
    }
}

class MockEmptyPlacesUseCase: PlacesUseCase {
    func getPlaces(offset: Int, limit: Int, location: Location) -> Single<PaginationResult<[Place]>> {
        .just(.success(data: [], totalCount: 0))
    }
}

class MockErrorPlacesUseCase: PlacesUseCase {
    func getPlaces(offset: Int, limit: Int, location: Location) -> Single<PaginationResult<[Place]>> {
        .just(.failure(errorMessage: "", statusCode: 500))
    }
}

class MockOneResultPlacesUseCase: PlacesUseCase {
    func getPlaces(offset: Int, limit: Int, location: Location) -> Single<PaginationResult<[Place]>> {
        .just(.success(data: [.init(id: "", name: "", address: "")], totalCount: 1))
    }
}

extension PlacesUseCase {
    func getPlacePhoto(placeID: String) -> Single<AppResult<PlacePhoto>> {
        .just(.failure(errorMessage: "", statusCode: 0))
    }
    
    func set(mode: String) {
        
    }
    
    func getSavedMode() -> String? {
        nil
    }
}

class MockLocationService: LocationService {
    let subject = PublishSubject<Location>()
    func getCurrentLocation() -> Observable<Location> {
        return subject
    }
}

// MARK: Helpers
enum LocationError: Error {
    case unKnownError
}
