//
//  EnterPoint.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 25.12.2023.
//

import Foundation

public enum EnterPoint {
    case weather(location: UserLocation, language: String)
    case searchCity(text: String, language: String)
    
    var urlRequest: URLRequest {
        switch self {
        case .weather(let location, let lang):
            var urlRequest = URLRequest(url: URL(string: "https://api.weather.yandex.ru/v2/forecast?lat=\(location.latitude)&lon=\(location.longitude)&lang=\(lang)&extra=true")!)
            urlRequest.httpMethod = "GET"
            urlRequest.allHTTPHeaderFields = ["X-Yandex-API-Key": "130e9d69-4784-427e-ab44-0fa8e37aab2a"]
            return urlRequest
        case .searchCity(let text, let lang):
            let apiGeo = "f4cbb72b-8afe-44d9-9dda-e7f000cda135"
            let urlRequest = URLRequest(url: URL(string: "https://geocode-maps.yandex.ru/1.x/?apikey=\(apiGeo)&geocode=\(text)&lang=\(lang)&format=json")!)
            return urlRequest
        }
        
    }
}
