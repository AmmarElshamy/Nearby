//
//  RxSwift+Extensions.swift
//  Nearby
//
//  Created by Ammar Elshamy on 10/10/2021.
//

import Foundation
import RxSwift

public extension Observable {
    func subscribeOnUi(onNext: ((Element) -> Void)?, onError: ((Error) -> Void)?) -> Disposable {
        return observe(on: MainScheduler.instance).subscribe(onNext: onNext, onError: onError)
    }
}

