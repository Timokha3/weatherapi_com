//
//  CityMapper.swift
//  Weather_Swift
//
//  Created by Timur on 23.02.2024.
//

import Foundation

final class CityMapper {
    func toDTO(serverModel: CityModel) -> CityDTO {
        let model = CityDTO(
            id: serverModel.id,
            cityName: serverModel.name,
            regionName: serverModel.region,
            countryName: serverModel.country,
            lat: serverModel.lat,
            lon: serverModel.lon
        )
        return model
    }
    
    func toDTO(serverModel: [CityModel]) -> [CityDTO] {
        var model = [CityDTO]()
        serverModel.forEach { item in
            model.append(self.toDTO(serverModel: item))
        }
        return model
    }
}
