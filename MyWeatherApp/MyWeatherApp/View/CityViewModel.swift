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

class CityListViewModel: ObservableObject {
    @Published var CityList: [String: [City]] = [:]
    
    init() {
        do {
            self.CityList = try loadCity()
            print("파일 불러오기 완료!")
        } catch CSVParseError.notFound {
            print("파일을 찾을 수 없습니다.")
        } catch CSVParseError.invalidFile {
            print("잘못된 형식의 파일입니다.")
        } catch {
            print("알 수 없는 에러 발생!!")
        }
    }
    
    private func loadCity() throws -> [String: [City]] {
        var cityList: [String: [City]] = [:]
        
        do {
            guard let path = Bundle.main.path(forResource: "KoreaCity", ofType: "csv") else { throw CSVParseError.notFound }
            
            let data = try Data(contentsOf: URL(filePath: path))
            let encodedData = String(data: data, encoding: .utf8)
            
            if let dataArr = encodedData?.components(separatedBy: "\n").map({ $0.trimmingCharacters(in: .newlines).components(separatedBy: ",") }) {
                for arr in dataArr {
                    if cityList[arr[0]] == nil {    // 키 값이 존재하지 않으면
                        cityList[arr[0]] = [City(Sigungu: arr[1], Lon: arr[2], Lat: arr[3])]
                    } else {    // 이미 키 값이 존재하면
                        cityList[arr[0]]?.append(City(Sigungu: arr[1], Lon: arr[2], Lat: arr[3]))
                    }
                }
            }
        } catch {
            throw CSVParseError.invalidFile
        }
        
        return cityList
    }
}
