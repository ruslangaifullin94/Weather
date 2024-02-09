//
//  MainViewModel.swift
//  Weather Watch Watch App
//
//  Created by Руслан Гайфуллин on 09.02.2024.
//

import Foundation
import Combine

final class ViewModelFactory {
    func makeViewModel() -> MainViewModel {
        let networkManager = CoreNetworkManager()
        let mapper = CoreMapper()
        let weatherApiService = WeatherApiService(networkManager: networkManager, mapper: mapper)
        let mainViewModel = MainViewModel(weatherApiService: weatherApiService)
        return mainViewModel
    }
}


final class MainViewModel: ObservableObject {
    
    private let connect = PhoneConnect.shared
    
    @Published var cities = Set<CityWatch>()
    
    private let weatherApiService: WeatherApiService
    
    private var subscriptions =  Set<AnyCancellable>()
    
    init(weatherApiService: WeatherApiService) {
        self.weatherApiService = weatherApiService
    }
    
    
    func getWeather() {
        connect.$locations
            .sink { [weak self] locations in
                guard let self else { return }
                locations.forEach { location in
                    Task { @MainActor in
                        do {
                            let city = try await self.weatherApiService.getWeather(location: location)
                            self.cities.insert(city)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
        }.store(in: &subscriptions)
    }
}
