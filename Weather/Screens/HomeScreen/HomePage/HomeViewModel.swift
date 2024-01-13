//
//  HomeViewModel.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 28.12.2023.
//

import Foundation
import Combine

final class HomeViewModel {
    
    enum State {
        case loading
        case loaded(city: City)
        case error(error: String)
    }
    
    private var weatherApiService: WeatherApiServiceProtocol
    private var userLocation: UserLocation
    private var forCurrentLocation: Bool
    
    @Published var state: State = .loading
    
    
    init(weatherApiService: WeatherApiServiceProtocol, 
         userLocation: UserLocation,
         forCurrentLocation: Bool)
    {
        self.weatherApiService = weatherApiService
        self.userLocation = userLocation
        self.forCurrentLocation = forCurrentLocation
        getWeather(userLocation: userLocation)
    }
    
    private func getWeather(userLocation: UserLocation) {
        print("Грузим погоду")
        if forCurrentLocation {
            Task { @MainActor [weak self] in
                guard let self else { return }
                do {
                    let city = try await weatherApiService.getWeatherCurrentLocation()
                    state = .loaded(city: city)
                } catch {
                    state = .error(error: error.localizedDescription)
                }
            }
            return
        } else {
            Task { @MainActor [weak self] in
                guard let self else { return }
                do {
                    let city = try await weatherApiService.getWeather(for: userLocation)
                    state = .loaded(city: city)
                } catch {
                    state = .error(error: error.localizedDescription)
                }
            }
        }
    }
}

extension HomeViewModel {
    func refresh() {
        getWeather(userLocation: userLocation)
    }
}
