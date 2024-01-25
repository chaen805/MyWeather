//
//  String+Extension.swift
//  MyWeatherApp
//
//  Created by Chaeeun Shin on 1/25/24.
//

import Foundation

extension String {
    func convertToCity() -> City {
        let arr = self.components(separatedBy: "-")
        return City(sigungu: arr[0], lon: arr[1], lat: arr[2])
    }
}
