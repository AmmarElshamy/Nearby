//
//  Bundle+Extensions.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import UIKit

public extension NSObject {
    static var fileName: String {
        return String(describing: self)
    }
}

public extension NSObject {
    static var bundle: Bundle {
        return Bundle.create(for: self)
    }
}

public extension Bundle {
    static func create(for type: AnyClass) -> Bundle {
        Bundle(for: type)
    }
}

public extension UINib {
    static func create(for type: AnyClass) -> UINib {
        UINib.init(nibName: String.init(describing: type), bundle: Bundle.init(for: type))
    }
}
