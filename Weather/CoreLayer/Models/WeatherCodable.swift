//
//  Weather.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 25.12.2023.
//

import Foundation

// MARK: - WeatherCodable
struct WeatherCodable: Codable {
    let now: Double
    let nowDt: String
    let info: Info
    let geoObject: GeoObject
    let yesterday: Yesterday
    let fact: Fact
    let forecasts: [Forecast]
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

// MARK: - Forecast
struct Forecast: Codable {
    let date: Date
    let dateTs, week: Double
    let sunrise, sunset, riseBegin, setEnd: String
    let moonCode: Double
    let moonText: String
    let parts: Parts
    let hours: [Hour]
    let biomet: Biomet?
}

// MARK: - Biomet
struct Biomet: Codable {
    let index: Double
    let condition: String
}

// MARK: - Hour
struct Hour: Codable {
    let hour: String
    let hourTs, temp, feelsLike: Int
    let icon: String
    let condition: String
    let cloudness: Double
    let precType: Double
    let precStrength: Double
    let isThunder: Bool
    let windDir: String?
    let windSpeed, windGust: Double?
    let pressureMm, pressurePa, humidity, uvIndex: Double?
    let soilTemp: Double?
    let soilMoisture, precMm: Double?
    let precPeriod, precProb: Double
}

// MARK: - Parts
struct Parts: Codable {
//    let evening, dayShort, nightShort, morning: Day?
    let day, night: Day
}

// MARK: - Day
struct Day: Codable {
//    let source: String
    let tempMin: Int
    let tempAvg: Int
    let tempMax: Int
    let windSpeed: Double?
    let windGust: Double?
    let windDir: String?
    let pressureMm: Double?
    let pressurePa: Double?
    let humidity: Int
    let soilTemp: Double?
    let soilMoisture, precMm: Double?
    let precProb: Int
    let precPeriod: Double?
    let cloudness: Double
    let precType: Double?
    let precStrength: Double?
    let icon: String
    let condition: String
    let uvIndex: Int?
    let feelsLike: Int
    let daytime: PurpleDaytime
    let polar: Bool
    let freshSnowMm: Double?
    let temp: Int?
}

enum PurpleDaytime: String, Codable {
    case d = "d"
    case n = "n"
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

// MARK: - Info
struct Info: Codable {
    let n: Bool
    let geoid: Double?
    let url: String
    let lat, lon: Double
    let tzinfo: Tzinfo
    let defPressureMm, defPressurePa: Double?
    let slug: String?
    let zoom: Double
    let nr, ns, nsr, p: Bool
    let f: Bool
    let h: Double?
}

// MARK: - Tzinfo
struct Tzinfo: Codable {
    let name, abbr: String
    let dst: Bool
    let offset: Double
}

// MARK: - Yesterday
struct Yesterday: Codable {
    let temp: Double
}
