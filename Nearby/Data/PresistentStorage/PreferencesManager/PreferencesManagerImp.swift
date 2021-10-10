//
//  PreferenceManagerImp.swift
//  Nearby
//
//  Created by Ammar Elshamy on 10/10/2021.
//

import Foundation

class PreferencesManagerImp {
    private let modeKey = "modeKey"
    
    private let userDefaults = UserDefaults.standard
}

extension PreferencesManagerImp: PreferencesManager {
        func set(mode: String) {
        userDefaults.setValue(mode, forKey: modeKey)
    }
    
    func getMode() -> String? {
        userDefaults.string(forKey: modeKey)
    }
}

