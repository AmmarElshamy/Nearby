//
//  PlacesListViewModel.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import Foundation
import RxSwift
import RxRelay

struct PlacesListViewModel {
    private let disposeBag = DisposeBag()
    let cellViewModels = BehaviorRelay<[PlaceCellViewModel]>(value: [])
    
    init() {
        
    }
}
