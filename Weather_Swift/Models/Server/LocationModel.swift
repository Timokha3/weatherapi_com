//
//  LocationModel.swift
//  Weather_Swift
//
//  Created by Timur on 24.02.2024.
//

import Foundation

struct LocationModel: Decodable {
    let name: String            // "Ханты-Мансийск"
    let region: String          // "Khanty-Mansiy",
    let country: String         // "Россия",
    let lat: Double             // 61,
    let lon: Double             // 69,
    let tzId: String            // "Asia/Yekaterinburg",
    let localtimeEpoch: Double  //1708759902,
    let localtime: String       // "2024-02-24 12:31"
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case region = "region"
        case country = "country"
        case lat = "lat"
        case lon = "lon"
        case tzId = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime = "localtime"
    }
}
