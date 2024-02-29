//
//  ForecastMapper.swift
//  Weather_Swift
//
//  Created by Timur on 25.02.2024.
//

import Foundation

final class ForecastMapper {
    /*func toDTO(serverModel: ForecastModel) -> ForecastDTO {
        var forecastData: [ForecastDataDTO] = []
        for item in serverModel.list {
            forecastData.append(ForecastDataDTO(
                                    id: item.weather[0].id,
                                    main: item.weather[0].description,
                                    icon: item.weather[0].icon,
                                    temp: item.main!.temp,
                                    dateTime: item.dt_txt!,
                                    date: Date(timeIntervalSince1970: item.dt)))
        }
        return ForecastDTO(
            cityName: serverModel.city.name,
            forecastData: forecastData.sorted(by: { $0.date > $1.date}) )
    }*/
}
