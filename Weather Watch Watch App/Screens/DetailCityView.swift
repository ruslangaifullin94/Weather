//
//  DetailCityView.swift
//  Weather Watch Watch App
//
//  Created by Руслан Гайфуллин on 07.02.2024.
//

import SwiftUI

struct DetailCityView: View {
    @Binding var selectedCity: CityWatch?
    var body: some View {
        ZStack {
            Color.green // Замените на цвет или изображение фона, которое вы хотите использовать
                .edgesIgnoringSafeArea(.all) // Игнорирует безопасную область экрана, чтобы фон занимал всю доступную область
            
            VStack {
                Spacer()
                if let selectedCity {
                    Text("\(selectedCity.weather.fact.temp) °C") // Замените на вашу переменную с температурой
                        .font(.title)
                    Text("\(selectedCity.name)") // Замените на вашу переменную с названием города
                        .font(.headline)
                } else {
                    EmptyView()
                }
                
                Spacer()
            }
        }
    }
}
//
//#Preview {
//    DetailCityView(selectedCity: nil)
//}
