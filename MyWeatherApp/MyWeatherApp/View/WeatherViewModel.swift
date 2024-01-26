//
//  CityViewModel.swift
//  MyWeatherApp
//
//  Created by Chaeeun Shin on 1/23/24.
//

import SwiftUI
import Combine

enum CSVParseError: Error {
    case notFound
    case invalidFile
}

class WeatherViewModel: ObservableObject {
    @AppStorage(UserDefaultsKey.isFirstRun.rawValue) private var isFirstRun = true
    @AppStorage(UserDefaultsKey.sido.rawValue) private var storedSido: String = ""
    @AppStorage(UserDefaultsKey.city.rawValue) private var storedCity: String = ""
    
    @Published var cityList: [String: [City]] = [:]
    
    @Published var sido: String = "" {
        didSet {
            storedSido = sido
        }
    }
    @Published var city = City(sigungu: "", lon: "", lat: "") {
        didSet {
            storedCity = city.convertoToString()
        }
    }
    @Published var weatherInformation: WeatherInformation?
    
    @Published var showLocationSheet: Bool = false
    @Published var tempSido: String = ""
    @Published var tempCity = City(sigungu: "", lon: "", lat: "")
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        do {
            try loadCity()
            print("파일 불러오기 완료!")
            
            if isFirstRun {     // 첫 실행일 경우
                sido = "서울특별시"
                city = cityList["서울특별시"]![0]    // 강남구
                
                isFirstRun.toggle()
            } else {
                sido = storedSido
                city = storedCity.convertToCity()
            }
        } catch CSVParseError.notFound {
            print("파일을 찾을 수 없습니다.")
        } catch CSVParseError.invalidFile {
            print("잘못된 형식의 파일입니다.")
        } catch {
            print("알 수 없는 에러 발생!!")
        }
        
        getWeatherData()
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
        
        getWeatherData()
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
    
    private func getWeatherData() {
        WeatherNetwork(city: self.city).getWeatherInformation()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: {[weak self] in
                    guard case .failure(let error) = $0 else { return }
                    print(error.localizedDescription)
                    self?.weatherInformation = nil
                },
                receiveValue: {[weak self] weather in
                    self?.weatherInformation = weather
                }
            )
            .store(in: &cancellables)
    }
}
