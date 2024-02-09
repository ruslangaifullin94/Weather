//
//  SecondView.swift
//  Weather Watch Watch App
//
//  Created by Руслан Гайфуллин on 01.02.2024.
//

import SwiftUI


struct ChooseCityView: View {
    @StateObject var viewModel: MainViewModel
    @Binding var selectedCity: CityWatch?
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            List(viewModel.cities.sorted(by: { $0.name < $1.name }), id: \.name) { city in
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
