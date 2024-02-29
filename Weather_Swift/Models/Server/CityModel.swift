//
//  CityModel.swift
//  Weather_Swift
//
//  Created by Timur on 23.02.2024.
//

import Foundation

struct CityModel: Decodable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case region = "region"
        case lat = "lat"
        case lon = "lon"
        case country = "country"
    }
    /*
      "id": 2206716,
      "name": "Томск",
      "region": "Tomsk",
      "country": "Россия",
      "lat": 56.5,
      "lon": 84.97,
      "url": "tomsk"
     */

}
