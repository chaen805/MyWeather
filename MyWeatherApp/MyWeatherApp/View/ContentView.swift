//
//  ContentView.swift
//  MyWeatherApp
//
//  Created by Chaeeun Shin on 1/23/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    var body: some View {
        List {
            ForEach(Array(viewModel.cityList.keys).sorted(), id: \.self) { key in
                Section {
                    ForEach(viewModel.cityList[key] ?? [], id: \.self) { city in
                        HStack {
                            Text(city.sigungu)
                            
                            Text(city.lat)
                            
                            Text(city.lon)
                        }
                    }
                } header: {
                    Text(key)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
