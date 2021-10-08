//
//  DiManager.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import UIKit
import Swinject

enum DiManager {
    private static var assembler: Assembler? {
        get {
            return AppDelegate.shared.assembler
        }
        set {
            AppDelegate.shared.assembler = newValue
        }
    }
    
    static func assembleDependency() {
        let container = Container()
        assembler = Assembler(container: container)
        assembler?.apply(assemblies: [
            AppAssembly()
        ])
    }
}
