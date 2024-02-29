//
//  FavoriteService.swift
//  Weather_Swift
//
//  Created by Timur on 26.02.2024.
//

import Foundation

protocol FavoritesServiceProtocol {
    func add(_ cityId: Int)
    func remove(_ cityId: Int)
    func isFavorite(_ cityId: Int) -> Bool
    func getFavorites() -> [Int]
}

final class FavoritesService: FavoritesServiceProtocol {
    
    var favorites: Set<Int> = LocalStorage.shared.favorites

    func isFavorite(_ cityId: Int) -> Bool {
        return favorites.contains(cityId)
    }
      
    /// Добавляет в избранное пользователя
    /// - Parameters:
    ///   - cityId: Id города
    func add(_ cityId: Int) {
        favorites.insert(cityId)
        LocalStorage.shared.favorites = favorites
        print(favorites)
    }
    
    func remove(_ cityId: Int) {
        favorites.remove(cityId)
        LocalStorage.shared.favorites = favorites
    }
        
    func getFavorites() -> [Int] {
        return Array(favorites)
    }
    
}
