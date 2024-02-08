//
//  SecondView.swift
//  Weather Watch Watch App
//
//  Created by Руслан Гайфуллин on 01.02.2024.
//

import SwiftUI


struct ChooseCityView: View {
//    @StateObject var viewModel: MainViewModel
//    @State var cities: [City]
    let cities = [CityWatch(name: "Moscow", weather: WeatherCityWatch(fact: FactWeatherWatch(temp: -12, feelLike: -15, condition: "snow", icon: nil)))] // Замените на ваш список городов
    @Binding var selectedCity: CityWatch?
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            List(cities, id: \.name) { city in
                Button(action: {
                    selectedCity = city
                    isPresented.toggle()
                }) {
                    Text(city.name)
                }
            }
            .navigationTitle("Выберите город")
            
        }
    }
}
