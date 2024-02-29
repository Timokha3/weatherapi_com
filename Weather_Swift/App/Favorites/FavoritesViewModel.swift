//
//  FavoritesViewModel.swift
//  Weather_Swift
//
//  Created by Timur on 29.02.2024.
//

import Foundation
import Moya

protocol FavoritesViewModelProtocol {
    func getCurrentWeatherById(id: Int, completion: @escaping (_ item: CurrentDataModel) -> Void)
    // favorites
    func addFavorite(_ cityId: Int)
    func removeFavorite(_ cityId: Int)
    func isFavorites(_ cityId: Int) -> Bool
    var favorites: [CityDTO] { get }
}

final class FavoritesViewModel: FavoritesViewModelProtocol {
    
    @Injected var apiProvider: MoyaProvider<WeatherApi>?
    @Injected var favoriteService: FavoritesServiceProtocol?
    
    func getCurrentWeatherById(id: Int, completion: @escaping (CurrentDataModel) -> Void) {
        if id > 0 {
            apiProvider?.request(.getCurrentWeatherByCityNameOrById(cityname: "id:\(id)")) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let response):
                    print(response.statusCode)
                    print(String(bytes: response.data, encoding: .utf8) as Any)
                    let data = try! JSONDecoder().decode(CurrentDataModel.self, from: response.data)
                    completion(data)
                }
            }
        }
    }
    
//MARK: - Избранное
    var favorites: [CityDTO] {
        var cities = [CityDTO]()
        favoriteService?.getFavorites().forEach { item in
            cities.append(CityDTO.getCity(id: item))
        }
        return cities
    }
    
    func addFavorite(_ cityId: Int) {
        favoriteService?.add(cityId)
    }
    
    func removeFavorite(_ cityId: Int) {
        favoriteService?.remove(cityId)
    }
    
    func isFavorites(_ cityId: Int) -> Bool {
        return favoriteService?.isFavorite(cityId) ?? false
    }
    
}
