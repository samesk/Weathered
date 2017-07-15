//
//  Forecast.swift
//  Weathered
//
//  Created by Samuel Eskenasy on 13/07/2017.
//  Copyright © 2017 Samuel Eskenasy. All rights reserved.
//

import Foundation
import SwiftyJSON


class Forecast {
    
    fileprivate var _date: String!
    fileprivate var _weatherType: String!
    fileprivate var _highTemp: Int!
    fileprivate var _lowTemp: Int!
    
    var date: String{
        get {
            return _date
        } set {
            _date = newValue
        }
    }
    
    var weatherType: String{
        get{
            return _weatherType
        } set {
            _weatherType = newValue
        }
    }
    
    var highTemp: Int{
        get {
            return _highTemp
        } set {
            _highTemp = newValue
        }
    }
    
    var lowTemp: Int {
        get {
            return _lowTemp
        } set {
            _lowTemp = newValue
        }
    }
    
    class func loadForecastFromData(_ APIData: Data) -> [Forecast]{
        
        var forecast = [Forecast] ()
        let json = JSON(data: APIData)
        
        if let list = json["list"].array {
            for day in list {
                let dayForecast = Forecast()
                dayForecast.highTemp = day["day"]["max"].intValue
                dayForecast.lowTemp = day["day"]["min"].intValue
                dayForecast.weatherType = day["weather"][0]["main"].stringValue
                
                let date = day["dt"].doubleValue
                let unixConvretedDate = Date(timeIntervalSince1970: date)
                dayForecast.date = unixConvretedDate.dayOfTheWeek()
                forecast.append(dayForecast)
                
            }
        }
     return forecast
    }
    
    
    
    
    
    
}

