//
//  WeatherView.swift
//  MyWeatherApp
//
//  Created by Chaeeun Shin on 1/24/24.
//

import SwiftUI

struct WeatherView: View {
    let sido = "경상남도"
    let sigungu = "창원시 마산합포구"
    let iconName = "02n"
    let temp = "-8"
    let discription = "약간 흐림"
    let windSpeed = "10.3"
    let humidity = "23"
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                VStack {
                    Group {
                        Text(sido)
                        
                        Text(sigungu)
                    }
                    .font(.cityTitle)
                    
                    Spacer()
                        .frame(maxHeight: 60)
                    
                    Image(iconName)
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .padding(.horizontal, 76)
                    
                    Text(temp + "º")
                        .font(.temperature)
                    
                    Text(discription)
                    
                    Spacer()
                        .frame(maxHeight: 40)
                    
                    HStack {
                        AdditionalInformationView(type: .wind, value: "10.3")
                        
                        Spacer()
                        
                        AdditionalInformationView(type: .humidity, value: "24.7")
                    }
                    .padding(.horizontal, 60)
                    .padding(.bottom, 36)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "globe")
                }
            }
            .foregroundStyle(.content)
        }
    }
}

enum AdditionalInformation: String {
    case wind = "풍속"
    case humidity = "습도"
    
    var unit: String {
        switch self {
        case .wind:
            return "m/s"
        case .humidity:
            return "%"
        }
    }
    
    var iconName: String {
        switch self {
        case .wind:
            return "wind"
        case .humidity:
            return "humidity"
        }
    }
}

private struct AdditionalInformationView: View {
    private let type: AdditionalInformation
    private let value: String
    
    fileprivate init(type: AdditionalInformation, value: String) {
        self.type = type
        self.value = value
    }
    
    fileprivate var body: some View {
        VStack(spacing: 4) {
            Image(type.iconName)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 50)
            
            Text(type.rawValue)
                .font(.infoTitle)
            
            Text(value + type.unit)
                .font(.infoContent)
        }
    }
}

#Preview {
    WeatherView()
}
