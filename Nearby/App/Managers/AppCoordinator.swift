//
//  AppCoordinator.swift
//  Nearby
//
//  Created by Ammar Elshamy on 08/10/2021.
//

import UIKit

class AppCoordinator {
    
    private static var window: UIWindow? {
        AppDelegate.shared.window
    }
    
    static func start() {
        let rootNavigationController = UINavigationController()
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
}
