//
//  WeatherInformation.swift
//  MyWeatherApp
//
//  Created by Chaeeun Shin on 1/25/24.
//

import Foundation

struct WeatherInformation: Decodable {
    let weather: [Weather]
    let temp: Temp
    let wind: Wind
    
    enum CodingKeys: String, CodingKey {
        case weather
        case temp = "main"
        case wind
    }
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Temp: Decodable {
    let temp: Double
    let fillsLike: Double
    let minTemp: Double
    let maxTemp: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case fillsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case humidity
    }
}

struct Wind: Decodable {
    let speed: Double
}
