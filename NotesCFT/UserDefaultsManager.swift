//
//  UserDefaultsManager.swift
//  NotesCFT
//
//  Created by Кирилл Зубков on 04.02.2024.
//

import Foundation

class UserDafaultsManager {
    
    static func getDidFirstLaunch() -> Bool {
        return UserDefaults.standard.bool(forKey: "FirstLaunch")
    }
    
    static func setDidFirstLaunch(bool: Bool) {
        UserDefaults.standard.setValue(bool, forKey: "FirstLaunch")
    }
    
}
