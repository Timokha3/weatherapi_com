//
//  ForecastViewModel.swift
//  Weather_Swift
//
//  Created by Timur on 25.02.2024.
//

import Foundation
import Moya

protocol ForecastViewModelProtocol {
    func getForecast(cityName: String, number: Int, completion: @escaping (_ item: CurrentDataModel) -> Void)
}

final class ForecastViewModel: ForecastViewModelProtocol {
    @Injected var apiProvider: MoyaProvider<WeatherApi>?
    
    func getForecast(cityName: String, number: Int, completion: @escaping (CurrentDataModel) -> Void) {
        if !cityName.isEmpty {
            apiProvider?.request(.getForecast(cityName:cityName, numberOfDays: number)) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let response):
                    print(response.statusCode)
                    print(String(bytes: response.data, encoding: .utf8) as Any)
                    let data = try! JSONDecoder().decode(CurrentDataModel.self, from: response.data)
                    completion(data)
                }
            }
        }
    }
    
}
