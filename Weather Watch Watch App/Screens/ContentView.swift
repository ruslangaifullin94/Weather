//
//  ContentView.swift
//  Weather Watch Watch App
//
//  Created by Руслан Гайфуллин on 28.01.2024.
//

import SwiftUI

struct ContentView: View {
    var viewModel = ViewModelFactory().makeViewModel()
//    let connect = PhoneConnect.shared

    @State private var isSecondViewPresented = false
    @State private var selectedCity: CityWatch?
    @State private var selection = 0
    var body: some View {
        
        TabView(selection: $selection) {
            MainCityView(selectedCity: $selectedCity)
                .tag(0)
                .ignoresSafeArea()
            DetailCityView(selectedCity: $selectedCity)
                .tag(1)
                .ignoresSafeArea()
        }
//        .onChange(of: selectedCity) {
//            selection = selectedCity != nil ? 1 : 0
//        }
        .onTapGesture {
            isSecondViewPresented.toggle()
            viewModel.getWeather()
        }
        .tabViewStyle(.verticalPage)
        .fullScreenCover(isPresented: $isSecondViewPresented, content: {
            ChooseCityView(viewModel: viewModel, selectedCity: $selectedCity, isPresented: $isSecondViewPresented)
        })
    }
}
