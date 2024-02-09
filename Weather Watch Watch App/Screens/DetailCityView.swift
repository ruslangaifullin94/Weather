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
            Color.green
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                if let selectedCity {
                    
                    Text("UI.Weather.LikeFeell".localized + " \(selectedCity.weather.fact.feelLike) " + "°C")
                        .font(.title2)
                    Text("\(selectedCity.weather.fact.condition)")
                        .font(.headline)
                } else {
                    EmptyView()
                }
                
                Spacer()
            }
        }
    }
}
