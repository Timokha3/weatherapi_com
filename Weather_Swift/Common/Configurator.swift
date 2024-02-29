//
//  Configurator.swift
//  Weather_Swift
//
//  Created by Timur on 22.02.2024.
//

import Foundation
import Moya

final class Configurator {
    static let shared = Configurator()
    
    private init() {}
    
    func setup() {
        setupApiServices()
        setupLocation()
        setupFavoriteService()
        setupMainViewModel()
        setupFavoritesViewModel()
    }
    
    private func setupApiServices() {
        let weatherApiService = MoyaProvider<WeatherApi>()
        ServiceLocator.shared.addServices(services: [weatherApiService])
    }
    
    private func setupLocation() {
        let location = LocationManager()
        ServiceLocator.shared.addService(service: location)
    }
    
    private func setupFavoriteService() {
        let service: FavoritesServiceProtocol = FavoritesService()
        ServiceLocator.shared.addService(service: service)
    }
    
    private func setupMainViewModel() {
        let vm: MainViewModelProtocol = MainViewModel()
        ServiceLocator.shared.addService(service: vm)
    }
    
    private func setupFavoritesViewModel() {
        let vm: FavoritesViewModelProtocol = FavoritesViewModel()
        ServiceLocator.shared.addService(service: vm)
    }
}
