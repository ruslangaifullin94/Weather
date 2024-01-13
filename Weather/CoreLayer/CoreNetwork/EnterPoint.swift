//
//  EnterPoint.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 25.12.2023.
//

import Foundation

enum EnterPoint {
    case weather(location: UserLocation)
    case searchCity(text: String)
    
    var urlRequest: URLRequest {
        switch self {
        case .weather(let location):
            var urlRequest = URLRequest(url: URL(string: "https://api.weather.yandex.ru/v2/forecast?lat=\(location.latitude)&lon=\(location.longitude)&extra=true")!)
            urlRequest.httpMethod = "GET"
            urlRequest.allHTTPHeaderFields = ["X-Yandex-API-Key": "e7cf7807-5577-4afa-b159-b5476261c577"]
            return urlRequest
        case .searchCity(let text):
            let apiGeo = "f4cbb72b-8afe-44d9-9dda-e7f000cda135"
            var urlRequest = URLRequest(url: URL(string: "https://geocode-maps.yandex.ru/1.x/?apikey=\(apiGeo)&geocode=\(text)&format=json")!)
            return urlRequest
        }
        
    }
}
