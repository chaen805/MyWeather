//
//  ContentView.swift
//  MyWeatherApp
//
//  Created by Chaeeun Shin on 1/23/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CityListViewModel()
    var body: some View {
        List {
            ForEach(Array(viewModel.CityList.keys).sorted(), id: \.self) { key in
                Section {
                    ForEach(viewModel.CityList[key] ?? [], id: \.self) { city in
                        HStack {
                            Text(city.Sigungu)
                            
                            Text(city.Lat)
                            
                            Text(city.Lon)
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
