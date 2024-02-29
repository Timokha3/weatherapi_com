//
//  ForecastModel.swift
//  Weather_Swift
//
//  Created by Timur on 23.02.2024.
//

import Foundation

struct ForecastModel: Decodable {
    let cod: String
    let message: Int
    let cnt: Int
    let city: CityModel
}
