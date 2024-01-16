//
//  SearchViewModel.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 28.12.2023.
//

import Foundation
import Combine

final class SearchViewModel {
    
    enum State {
        case initial
        case loaded(results: [CitySearchModel])
        case clearResults
        case error(error: String)
    }
    
    @Published var state: State = .initial
    
    private var weatherApiService: WeatherApiServiceProtocol
    
    init(weatherApiService: WeatherApiServiceProtocol) {
        self.weatherApiService = weatherApiService
    }
    
    private func getCities(text: String) {
        Task { @MainActor in
            do {
                let results = try await weatherApiService.getCities(for: text)
                state = .loaded(results: results)
            } catch {
                state = .error(error: error.localizedDescription)
            }
        }
    }
}

extension SearchViewModel {
    func searchCities(text: String) {
        getCities(text: text)
    }
    
    func clearResults() {
        state = .clearResults
    }
}
