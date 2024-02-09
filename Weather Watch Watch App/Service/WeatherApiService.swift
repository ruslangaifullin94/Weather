//
//  WeatherApiService.swift
//  Weather Watch Watch App
//
//  Created by Руслан Гайфуллин on 08.02.2024.
//

import Foundation


final class WeatherApiService {
    
    private let networkManager: CoreNetworkManager
    private let mapper: CoreMapperProtocol
    
    init(networkManager: CoreNetworkManager, mapper: CoreMapperProtocol) {
        self.networkManager = networkManager
        self.mapper = mapper
    }
    
    func getWeather(location: UserLocation) async throws -> CityWatch {
        let data = try await networkManager.getRequest(location: location)
        let weather = try await mapper.map(from: data, jsonType: WeatherCodable.self)
        let city = CityWatch(cityInfo: weather)
        return city
    }
}
