//
//  LocationView.swift
//  MyWeatherApp
//
//  Created by Chaeeun Shin on 1/24/24.
//

import SwiftUI

struct LocationView: View {
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    HStack {
                        Text("시 / 도")
                        
                        Spacer()
                        
                        Picker("", selection: $viewModel.tempSido) {
                            ForEach(Array(viewModel.cityList.keys).sorted(), id: \.self) { key in
                                Text(key)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    .listRowBackground(Color.clear)
                    
                    HStack {
                        Text("시 / 군 / 구")
                    
                        Spacer()
                        
                        Picker("", selection: $viewModel.tempCity) {
                            ForEach(viewModel.cityList[viewModel.tempSido] ?? [], id: \.self) { city in
                                Text(city.sigungu)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    .listRowBackground(Color.clear)
                }
                .foregroundStyle(Color.content)
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                
                Button {
                    // TODO: - 선택 위치 저장 및 api 호출
                    viewModel.saveLocation()
                } label: {
                    Text("저장")
                        .font(.headline)
                        .foregroundStyle(.blue)
                        .padding(12)
                }
                .padding(.bottom, 32)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("지역 설정")
                        .font(.cityTitle)
                        .foregroundStyle(.content)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.closeLocationSheet()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.content)
                    }
                }
            }
        }
    }
}

#Preview {
    LocationView()
        .environmentObject(WeatherViewModel())
}
