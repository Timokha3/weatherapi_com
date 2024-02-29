//
//  ConditionModel.swift
//  Weather_Swift
//
//  Created by Timur on 24.02.2024.
//

import Foundation

struct ConditionModel: Decodable {
    let text: String        // "Небольшой снег",
    let icon: String        // "//cdn.weatherapi.com/weather/64x64/day/368.png",
    let code: Int           //1255
}
