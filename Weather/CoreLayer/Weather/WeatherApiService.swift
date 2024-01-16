//
//  WeatherApiService.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 25.12.2023.
//

import Foundation
import Combine

protocol WeatherApiServiceProtocol {
    func getCities(for city: String) async throws -> [CitySearchModel]
    func getWeatherCurrentLocation() async throws -> City
    func getWeather(for userLocation: UserLocation) async throws -> City
}

final class WeatherApiService {
    
    private let locationManager: LocationManagerProtocol
    private let networkManager: NetworkManagerProtocol
    private let mapper: CoreMapperProtocol
    
    private var userLocation: UserLocation?
    private var subscriptions = Set<AnyCancellable>()
    
    
    init(locationManager: LocationManagerProtocol,
         networkManager: NetworkManagerProtocol,
         mapper: CoreMapperProtocol) {
        self.locationManager = locationManager
        self.networkManager = networkManager
        self.mapper = mapper
    }
    
    private func getCurrentLocation() {
        CurrentLocationManager.shared.$location
            .sink { [unowned self] location in
                let userLocation = UserLocation(longitude: location.coordinate.longitude,
                                                latitude: location.coordinate.latitude)
                self.userLocation = userLocation
            }.store(in: &subscriptions)
    }
    
}


extension WeatherApiService: WeatherApiServiceProtocol {
    func getCities(for city: String) async throws -> [CitySearchModel] {
        let data = try await networkManager.getRequest(enterPoint: .searchCity(text: city))
        let locations = try await mapper.map(from: data, jsonType: SearchLocation.self)
        return locations.response.geoObjectCollection.featureMember.map(CitySearchModel.init)
    }
    
    
    func getWeather(for userLocation: UserLocation) async throws -> City {
        let data = try await networkManager.getRequest(enterPoint: .weather(location: userLocation))
        let weather = try await mapper.map(from: data, jsonType: WeatherCodable.self)
        let city = City(cityInfo: weather)
        return city
    }

    func getWeatherCurrentLocation() async throws -> City {
        getCurrentLocation()
        locationManager.requestLocation()
        guard let userLocation else {
            throw LocationErrors.locationNotFound
        }
        return try await getWeather(for: userLocation)
    }

    
}
