//
//  CurrentDataDTO.swift
//  Weather_Swift
//
//  Created by Timur on 26.02.2024.
//

import Foundation

struct CurrentDataDTO {
    var countryName: String
    var cityName: String
    var condition: String
    var iconUrl: String
    var temp: Double
    var time: String
}

extension CurrentDataDTO {
    static func getCurrentData(cityName: String) -> CurrentDataDTO {
        let model = CurrentDataDTO(
            countryName: "Россия",
            cityName: cityName,
            condition: "Переменная облачность",
            iconUrl: "//cdn.weatherapi.com/weather/64x64/day/113.png",
            temp: -20,
            time: "22:52"
        )
        return model
    }
}
