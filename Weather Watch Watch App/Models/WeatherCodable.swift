//
//  WeatherCodable.swift
//  Weather Watch Watch App
//
//  Created by Руслан Гайфуллин on 08.02.2024.
//

import Foundation

// MARK: - WeatherCodable
struct WeatherCodable: Codable {
    let geoObject: GeoObject
   
    let fact: Fact
}

// MARK: - Fact
struct Fact: Codable {
    let obsTime, uptime, temp, feelsLike: Int
    let icon: String
    let condition: String
    let cloudness: Double
    let precType, precProb: Double
    let precStrength: Double
    let isThunder: Bool
    let windSpeed: Double?
    let windDir: String?
    let pressureMm, pressurePa, humidity: Double?
    let daytime: String?
    let polar: Bool
    let season, source: String
    let accumPrec: [String: Double]?
    let soilMoisture: Double?
    let soilTemp, uvIndex: Double?
    let windGust: Double?
}


// MARK: - GeoObject
struct GeoObject: Codable {
    let district, locality, province, country: Country?
}

// MARK: - Country
struct Country: Codable {
    let id: Double
    let name: String
}

