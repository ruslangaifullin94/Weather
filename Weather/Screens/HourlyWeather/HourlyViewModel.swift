//
//  HourlyViewModel.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 16.01.2024.
//

import Foundation
import Combine

final class HourlyViewModel {
    
    enum State {
        case initial
        case loaded(city: City)
    }
    
    @Published var state: State = .initial
    private var city: City
    
    init(city: City) {
        self.city = city
        state = .loaded(city: city)
    }
    
}
