//
//  WeatherAPI.swift
//  Weather_Swift
//
//  Created by Timur on 23.02.2024.
//

import Foundation
import Moya

enum WeatherApi {
    case getCurrentWeatherByCityNameOrById(cityname: String)
    case getForecast(cityName: String, numberOfDays: Int)
    case search(text: String)
}

extension WeatherApi: TargetType {
    var baseURL: URL {
        return URL(string: Constants.baseURL)!
    }
    var path: String {
        switch self {
        case .getCurrentWeatherByCityNameOrById:
            return "current.json"
        case .getForecast:
            return "forecast.json"
        case .search(text: let text):
            return "search.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCurrentWeatherByCityNameOrById, .getForecast, .search:
            return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case let .getCurrentWeatherByCityNameOrById(cityname: cityName):
            var params: [String: Any] = [:]
            params["q"] = cityName
            params["lang"] = Constants.API.lang
            params["key"] = Constants.API.key
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case let .getForecast(cityName: cityName, numberOfDays: numberOfDay):
            var params: [String: Any] = [:]
            params["q"] = cityName
            params["days"] = numberOfDay
            params["lang"] = Constants.API.lang
            params["key"] = Constants.API.key
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case let .search(text: text):
            var params: [String: Any] = [:]
            params["q"] = text
            params["lang"] = Constants.API.lang
            params["key"] = Constants.API.key
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}

