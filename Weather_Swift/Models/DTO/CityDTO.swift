//
//  CityDTO.swift
//  Weather_Swift
//
//  Created by Timur on 22.02.2024.
//

import Foundation


struct CityDTO: Equatable {
    let id: Int
    let cityName: String
    let regionName: String
    let countryName: String
    let lat: Double
    let lon: Double
}

//MARK: - for Preview

extension CityDTO {    
    static func getCity(cityName: String) -> CityDTO {
        let model = CityDTO(
            id: 0,
            cityName: cityName,
            regionName: cityName,
            countryName: "Россия",
            lat: 69.004,
            lon: 61.005
        )
        return model
    }
    
    static func getCity(id: Int) -> CityDTO {
        let model = CityDTO(
            id: id,
            cityName: "-",
            regionName: "-",
            countryName: "-",
            lat: 0.0,
            lon: 0.0
        )
        return model
    }
}
