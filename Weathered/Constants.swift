//
//  Constants.swift
//  Weathered
//
//  Created by Samuel Eskenasy on 12/07/2017.
//  Copyright © 2017 Samuel Eskenasy. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()

let API_HOMEPAGE = "https://openweathermap.org"

let NOTIF_DOWLOAD_COMPLETE = NSNotification.Name("DataDownloaded")
let API_KEY = "&appid=afa0deddb42c4bbd2a554d6c96b5aa39"
let API_UNIT = "&units=metric"
let API_URL_CURRENT_WEATHER = "http://api.openweathermap.org/data/2.5/weather?lat=32.113808&lon=34.79018\(API_UNIT)\(API_KEY)"
let API_URL_FORECAST = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=32.11380&lon=34.79018cnt=8\(API_UNIT)\(API_KEY)"

