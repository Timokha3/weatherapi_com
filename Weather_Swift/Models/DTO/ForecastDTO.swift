//
//  ForecastDTO.swift
//  Weather_Swift
//
//  Created by Timur on 25.02.2024.
//

import Foundation

struct ForecastDTO: Decodable {
    let cityName: String
    let forecastData: [ForecastDataDTO]
}

struct ForecastDataDTO: Decodable {
    var id: Int
    var main: String = ""
    var icon: String = ""
    var temp: Double = 0.0
    var dateTime: String = ""
    var date: Date = Date()
}

//MARK: - for Preview

extension ForecastDTO {
    static func getForecast(cityName: String) -> ForecastDTO {
        
        let data = ForecastDataDTO(
            id: 0,
            main: "",
            icon: "",
            temp: 0,
            dateTime: ""
        )
        
        return ForecastDTO(cityName: cityName, forecastData: [data])
    }
}
