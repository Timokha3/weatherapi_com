//
//  MainViewModel.swift
//  Weather_Swift
//
//  Created by Timur on 25.02.2024.
//

import Foundation
import Moya

protocol MainViewModelProtocol {
    func findCity(completion: @escaping (_ item: CityDTO) -> Void)
    func findNearestCity(searchText: String, completion: @escaping (_ item: [CityModel]) -> Void)
    func getCurrentWeatherByCityName(cityName: String, completion: @escaping (_ item: CurrentDataModel) -> Void)
    func getCurrentWeatherById(id: Int, completion: @escaping (_ item: CurrentDataModel) -> Void)
    func searchCities(cityName: String, completion: @escaping (_ item: [CityDTO]) -> Void) async
    // favorites
    func addFavorite(_ cityId: Int)
    func removeFavorite(_ cityId: Int)
    func isFavorites(_ cityId: Int) -> Bool
}

final class MainViewModel: MainViewModelProtocol {
    
    @Injected var apiProvider: MoyaProvider<WeatherApi>?
    @Injected var locationManager: LocationManager?
    @Injected var favoriteService: FavoritesServiceProtocol?
    
    var currentLatitude: Double {
        return locationManager?.lastLocation?.coordinate.latitude ?? 55.75
    }
    
    var currentLongitude: Double {
        return locationManager?.lastLocation?.coordinate.longitude ?? 37.62
    }

    func findCity(completion: @escaping (_ item: CityDTO) -> Void) {
        print(#function)
        let text = "\(currentLatitude), \(currentLongitude)"
        
        findNearestCity(searchText: text) { items in
            if items.count > 0 {
                let currentDataDTO = CityMapper().toDTO(serverModel: items.first!)
                completion(currentDataDTO)
            }
        }
    }
    
    func findNearestCity(searchText: String, completion: @escaping ([CityModel]) -> Void) {
        apiProvider?.request(.search(text: searchText)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                print(response.statusCode)
                print(String(bytes: response.data, encoding: .utf8) as Any)
                let data = try! JSONDecoder().decode([CityModel].self, from: response.data)
                completion(data)
            }
        }
    }
    
    func getCurrentWeatherByCityName(cityName: String, completion: @escaping (CurrentDataModel) -> Void) {
        if !cityName.isEmpty {
            apiProvider?.request(.getCurrentWeatherByCityNameOrById(cityname: cityName)) { [weak self] result in
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
    
    func searchCities(cityName: String = "", completion: @escaping (_ item: [CityDTO]) -> Void) async {
        if cityName.isEmpty { return }
        
        let url = Constants.baseURL + "search.json?q=\(cityName)&key=" + Constants.API.key
        guard let url = URL(string: url) else {
            print("Error: Invalid url")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decoderData = try? JSONDecoder().decode([CityModel].self, from: data) {
                
                let cities = CityMapper().toDTO(serverModel: decoderData)
                completion(cities)
            } else {
                completion([CityDTO]())
            }
        } catch {
            print("Invalid data")
        }
    }
    
//MARK: - Избранное
    
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
