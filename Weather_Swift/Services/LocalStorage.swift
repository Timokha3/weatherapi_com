//
//  LocalStorage.swift
//  Weather_Swift
//
//  Created by Timur on 25.02.2024.
//

import Foundation

fileprivate enum LocalStorageKey: String {
    case favorites
    case searchHistory
}

protocol LocalStorageProtocol {
    var favorites: Set<Int> { get set }
    var cities: Set<String> { get set }
}

final class LocalStorage: LocalStorageProtocol {
    
    static let shared = LocalStorage()
    
    init() {}
    
    var favorites: Set<Int> {
        get {
            Set((UserDefaults.standard.array(forKey: LocalStorageKey.favorites.rawValue) as? [Int]) ?? [])
        }
        set {
            UserDefaults.standard.setValue(Array(newValue), forKey: LocalStorageKey.favorites.rawValue)
        }
    }
    
    var cities: Set<String> {
        get {
            Set((UserDefaults.standard.array(forKey: LocalStorageKey.favorites.rawValue) as? [String]) ?? [])
        }
        set {
            UserDefaults.standard.setValue(Array(newValue), forKey: LocalStorageKey.favorites.rawValue)
        }
    }
}
