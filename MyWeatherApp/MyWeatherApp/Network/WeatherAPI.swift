//
//  WeatherAPI.swift
//  MyWeatherApp
//
//  Created by Chaeeun Shin on 1/25/24.
//

import Foundation

struct WeatherAPI {
    static let scheme = "https"
    static let host = "api.openweathermap.org"
    static let path = "/data/2.5/weather"
    
    private let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    func getWeatherComponents(city: City) -> URLComponents {
        var components = URLComponents()
        
        components.scheme = WeatherAPI.scheme
        components.host = WeatherAPI.host
        components.path = WeatherAPI.path
        
        components.queryItems = [
            URLQueryItem(name: "lon", value: city.lon),
            URLQueryItem(name: "lat", value: city.lat),
            URLQueryItem(name: "lang", value: "kr"),
            URLQueryItem(name: "appid", value: key)
        ]
        
        return components
    }
}
