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
            ForEach(viewModel.CityList, id: \.self) { city in
                HStack {
                    Text(city.Sido)
                    
                    Text(city.Sigungu)
                    
                    Text(city.Lon.description)
                    
                    Text(city.Lat.description)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
