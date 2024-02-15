//
//  WeatherView.swift
//  MyWeatherApp
//
//  Created by Chaeeun Shin on 1/24/24.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel = WeatherViewModel()    
    @State private var showLocationSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                VStack {
                    Group {
                        Text(viewModel.sido)
                        
                        Text(viewModel.city.sigungu)
                    }
                    .font(.cityTitle)
                    
                    Spacer()
                        .frame(maxHeight: 60)
                    
                    if let weather = viewModel.weatherInformation {
                        Image(weather.weather[0].icon)
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .padding(.horizontal, 76)
                        
                        Text("\(Int(weather.temp.temp - 273.15))℃")
                            .font(.temperature)
                        
                        Text(weather.weather[0].description)
                        
                        Spacer()
                            .frame(maxHeight: 40)
                        
                        HStack {
                            AdditionalInformationView(type: .wind, value: String(weather.wind.speed))
                            
                            Spacer()
                            
                            AdditionalInformationView(type: .humidity, value: String(weather.temp.humidity))
                        }
                        .padding(.horizontal, 60)
                        .padding(.bottom, 36)
                    } else {
                        NetworkErrorView()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.openLocationSheet()
                    } label: {
                        Image(systemName: "globe")
                    }
                }
            }
            .foregroundStyle(.content)
            .sheet(isPresented: $viewModel.showLocationSheet) {
                LocationView()
                    .environmentObject(viewModel)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                    .presentationBackground(.ultraThinMaterial)
                    .presentationCornerRadius(36)
            }
        }
    }
}

private struct NetworkErrorView: View {
    fileprivate var body: some View {
        Image(systemName: "network.slash")
            .resizable()
            .renderingMode(.template)
            .scaledToFit()
            .padding(.horizontal, 76)
        
        Text("-")
            .font(.temperature)
        
        Text("네트워크 오류")
        
        Spacer()
            .frame(maxHeight: 40)
        
        HStack {
            AdditionalInformationView(type: .wind, value: "-")
            
            Spacer()
            
            AdditionalInformationView(type: .humidity, value: "-")
        }
        .padding(.horizontal, 60)
        .padding(.bottom, 36)
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
