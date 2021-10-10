//
//  DiManager.swift
//  Nearby
//
//  Created by Ammar Elshamy on 09/10/2021.
//

import UIKit
import Swinject

enum DiManager {
    static var assembler: Assembler = {
        let container = Container()
        return Assembler(container: container)
    }()
    
    static func assembleDependency() {
        assembler.apply(assemblies: [
            AppAssembly()
        ])
    }
}
