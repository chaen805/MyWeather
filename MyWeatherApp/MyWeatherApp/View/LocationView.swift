//
//  LocationView.swift
//  MyWeatherApp
//
//  Created by Chaeeun Shin on 1/24/24.
//

import SwiftUI

struct LocationView: View {
    @ObservedObject var viewModel = CityListViewModel()
    @Binding var showLocationSheet: Bool
    @State private var sido: String
    @State private var city: City
    
    init(viewModel: CityListViewModel = CityListViewModel(), showLocationSheet: Binding<Bool>) {
        self.viewModel = viewModel
        self._showLocationSheet = showLocationSheet
        self.sido = "서울특별시"
        self.city = viewModel.cityList["서울특별시"]![0]
    }

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    HStack {
                        Text("시 / 도")
                        
                        Spacer()
                        
                        Picker("", selection: $sido) {
                            ForEach(Array(viewModel.cityList.keys).sorted(), id: \.self) { key in
                                Text(key)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    .listRowBackground(Color.clear)
                    .onChange(of: sido) {
                        city = viewModel.cityList[sido]![0]
                    }
                    
                    HStack {
                        Text("시 / 군 / 구")
                        
                        Spacer()
                        
                        Picker("", selection: $city) {
                            ForEach(viewModel.cityList[sido] ?? [], id: \.self) { city in
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
                    showLocationSheet = false
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
                        showLocationSheet = false
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
    LocationView(showLocationSheet: .constant(true))
}
