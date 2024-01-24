//
//  CityViewModel.swift
//  MyWeatherApp
//
//  Created by Chaeeun Shin on 1/23/24.
//

import SwiftUI

enum CSVParseError: Error {
    case notFound
    case invalidFile
}

class WeatherViewModel: ObservableObject {
    @Published var cityList: [String: [City]] = [:]
    
    @Published var sido: String = "서울특별시"
    @Published var city = City(sigungu: "", lon: "", lat: "")
    
    @Published var showLocationSheet: Bool = false
    @Published var tempSido: String = ""
    @Published var tempCity = City(sigungu: "", lon: "", lat: "")
    
    init() {
        do {
            try loadCity()
            print("파일 불러오기 완료!")
            self.city = cityList["서울특별시"]![0]
        } catch CSVParseError.notFound {
            print("파일을 찾을 수 없습니다.")
        } catch CSVParseError.invalidFile {
            print("잘못된 형식의 파일입니다.")
        } catch {
            print("알 수 없는 에러 발생!!")
        }
    }
    
    func openLocationSheet() {
        tempSido = sido
        tempCity = city
        
        showLocationSheet = true
    }
    
    func closeLocationSheet() {
        showLocationSheet = false
    }
    
    func saveLocation() {
        sido = tempSido
        city = tempCity
        
        closeLocationSheet()
    }
    
    func selectFirstCity(sido: String) {
        self.tempCity = cityList[sido]![0]
    }
    
    private func loadCity() throws {
        do {
            guard let path = Bundle.main.path(forResource: "KoreaCity", ofType: "csv") else { throw CSVParseError.notFound }
            
            let data = try Data(contentsOf: URL(filePath: path))
            let encodedData = String(data: data, encoding: .utf8)
            
            if let dataArr = encodedData?.components(separatedBy: "\n").map({ $0.trimmingCharacters(in: .newlines).components(separatedBy: ",") }) {
                for arr in dataArr {
                    if self.cityList[arr[0]] == nil {    // 키 값이 존재하지 않으면
                        self.cityList[arr[0]] = [City(sigungu: arr[1], lon: arr[2], lat: arr[3])]
                    } else {    // 이미 키 값이 존재하면
                        self.cityList[arr[0]]?.append(City(sigungu: arr[1], lon: arr[2], lat: arr[3]))
                    }
                }
            }
        } catch {
            throw CSVParseError.invalidFile
        }
    }
}
