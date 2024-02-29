//
//  CurrentDataMapper.swift
//  Weather_Swift
//
//  Created by Timur on 27.02.2024.
//

import Foundation

final class CurrentDataMapper {
    func toDTO(serverModel: CurrentDataModel, isCelsius: Bool = true) -> CurrentDataDTO {
        let temp = isCelsius ? Double(serverModel.current.tempC) : serverModel.current.tempF
        
        let model = CurrentDataDTO(
            countryName: serverModel.location.country,
            cityName: serverModel.location.name,
            condition: serverModel.current.condition.text,
            iconUrl: serverModel.current.condition.icon,
            temp: temp,
            time: getTimeFromDate(unixtime: serverModel.location.localtimeEpoch, fullFormat: false)
        )
        return model
    }
}
