//
//  WeatherResponse.swift
//  IosWeather
//
//  Created by Daniel Marceta on 15.04.21.
//

import Foundation

struct WeatherResponse : Codable{
    var list = [WeatherItem]()
}

struct WeatherItem : Codable {
    var dt: Double
    var main : Main
    var weather = [Weather]()
}

struct Main : Codable {
    var temp: Double
    var pressure: Double
    var humidity: Double
}

struct Weather : Codable{
    var main : String
    var description : String
    var icon : String
}
