//
//  DateHelper.swift
//  Weather_Swift
//
//  Created by Timur on 23.02.2024.
//

import Foundation

func unixTimeToDateTime(unixtime: Double, fullFormat: Bool = false) -> String {
    let date = NSDate(timeIntervalSince1970: Double(unixtime))
    
    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.dateFormat = fullFormat ? "dd.MM.yyyy HH:mm" : "dd.MM.yyyy"
    return dayTimePeriodFormatter.string(from: date as Date)
}


func getTimeFromDate(unixtime: Double, fullFormat: Bool = false) -> String {
    let date = NSDate(timeIntervalSince1970: unixtime)
    
    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.dateFormat = fullFormat ? "dd.MM.yyyy HH:mm" : "HH:mm"
    return dayTimePeriodFormatter.string(from: date as Date)
}
