//
//  NetworkManager.swift
//  Weather Watch Watch App
//
//  Created by Руслан Гайфуллин on 09.02.2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func getRequest(location: UserLocation) async throws -> Data
}

final class CoreNetworkManager { }

extension CoreNetworkManager: NetworkManagerProtocol {
    
    func getRequest(location: UserLocation) async throws -> Data {
        var urlRequest = URLRequest(url: URL(string: "https://api.weather.yandex.ru/v2/forecast?lat=\(location.latitude)&lon=\(location.longitude)&lang=\(WeatherLocalization.shared.currentLanguage.rawValue)&extra=true")!)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["X-Yandex-API-Key": "130e9d69-4784-427e-ab44-0fa8e37aab2a"]
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.noInternet
        }
        print("http status code: \(response.statusCode)")
        return data
        
    }
}
