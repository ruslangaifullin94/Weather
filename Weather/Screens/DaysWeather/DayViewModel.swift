//
//  DayViewModel.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 14.01.2024.
//

import Foundation
import Combine

final class DayViewModel {
    
    enum State {
        case initial
        case loaded(city: City)
    }
    
    @Published var state: State = .initial
    private var forecast: City
    init(forecast: City) {
        self.forecast = forecast
        loadedState()
    }
    
    private func loadedState() {
        state = .loaded(city: forecast)
    }
}
