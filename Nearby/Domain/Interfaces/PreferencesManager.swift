//
//  PreferenceManager.swift
//  Nearby
//
//  Created by Ammar Elshamy on 10/10/2021.
//

import Foundation

protocol PreferencesManager {
    func set(mode: String)
    func getMode() -> String?
}
