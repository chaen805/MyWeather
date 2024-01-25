//
//  City.swift
//  MyWeatherApp
//
//  Created by Chaeeun Shin on 1/23/24.
//

import Foundation

struct City: Hashable, Equatable {
    let sigungu: String
    let lon: String
    let lat: String
    
    func convertoToString() -> String {
        return "\(self.sigungu)-\(self.lon)-\(self.lat)"
    }
}
