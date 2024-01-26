//
//  WeatherNetwork.swift
//  MyWeatherApp
//
//  Created by Chaeeun Shin on 1/26/24.
//

import Foundation
import Combine

class WeatherNetwork {
    private let session: URLSession
    let api = WeatherAPI()
    let city: City
    
    init(session: URLSession = .shared, city: City) {
        self.session = session
        self.city = city
    }
    
    func getWeatherInformation() -> AnyPublisher<WeatherInformation, URLError> {
        guard let url = api.getWeatherComponents(city: city).url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.unknown)
                }
                
                switch httpResponse.statusCode {
                case 200..<300:
                    return data
                case 400..<500:
                    throw URLError(.clientCertificateRejected)
                case 500..<599:
                    throw URLError(.badServerResponse)
                default:
                    throw URLError(.unknown)
                }
            }
            .decode(type: WeatherInformation.self, decoder: JSONDecoder())
            .mapError { $0 as! URLError }
            .eraseToAnyPublisher()
    }
}
