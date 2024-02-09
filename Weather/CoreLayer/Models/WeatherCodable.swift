//
//  Weather.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 25.12.2023.
//

import Foundation

// MARK: - WeatherCodable
public struct WeatherCodable: Codable {
    public let now: Double
    public let nowDt: String
    public let info: Info
    public let geoObject: GeoObject
    public let yesterday: Yesterday
    public let fact: Fact
    public let forecasts: [Forecast]
}

// MARK: - Fact
public struct Fact: Codable {
    public let obsTime, uptime, temp, feelsLike: Int
    public let icon: String
    public let condition: String
    public let cloudness: Double
    public let precType, precProb: Double
    public let precStrength: Double
    public let isThunder: Bool
    public let windSpeed: Double?
    public let windDir: String?
    public let pressureMm, pressurePa, humidity: Double?
    public let daytime: String?
    public let polar: Bool
    public let season, source: String
    public let accumPrec: [String: Double]?
    public let soilMoisture: Double?
    public let soilTemp, uvIndex: Double?
    public let windGust: Double?


}

// MARK: - Forecast
public struct Forecast: Codable {
    public let date: Date
    public let dateTs, week: Double
    public let sunrise, sunset, riseBegin, setEnd: String
    public let moonCode: Double
    public let moonText: String
    public let parts: Parts
    public let hours: [Hour]
    public let biomet: Biomet?
}

// MARK: - Biomet
public struct Biomet: Codable {
    public let index: Double
    public let condition: String
}

// MARK: - Hour
public struct Hour: Codable {
    public let hour: String
    public let hourTs, temp, feelsLike: Int
    public let icon: String
    public let condition: String
    public let cloudness: Double
    public let precType: Double
    public let precStrength: Double
    public let isThunder: Bool
    public let windDir: String?
    public let windSpeed, windGust: Double?
    public let pressureMm, pressurePa, uvIndex: Double?
    public let humidity: Int
    public let soilTemp: Double?
    public let soilMoisture, precMm: Double?
    public let precPeriod: Double
    public let precProb: Int
}

// MARK: - Parts
public struct Parts: Codable {
//    let evening, dayShort, nightShort, morning: Day?
    public let day, night: Day
}

// MARK: - Day
public struct Day: Codable {
//    let source: String
    public let tempMin: Int
    public let tempAvg: Int
    public let tempMax: Int
    public let windSpeed: Double?
    public let windGust: Double?
    public let windDir: String?
    public let pressureMm: Double?
    public let pressurePa: Double?
    public let humidity: Int
    public let soilTemp: Double?
    public let soilMoisture, precMm: Double?
    public let precProb: Int
    public let precPeriod: Double?
    public let cloudness: Double
    public let precType: Double?
    public let precStrength: Double?
    public let icon: String
    public let condition: String
    public let uvIndex: Int?
    public let feelsLike: Int
    public let daytime: PurpleDaytime
    public let polar: Bool
    public let freshSnowMm: Double?
    public let temp: Int?
}

public enum PurpleDaytime: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - GeoObject
public struct GeoObject: Codable {
    public let district, locality, province, country: Country?
}

// MARK: - Country
public struct Country: Codable {
    public let id: Double
    public let name: String
}

// MARK: - Info
public struct Info: Codable {
    public let n: Bool
    public let geoid: Double?
    public let url: String
    public let lat, lon: Double
    public let tzinfo: Tzinfo
    public let defPressureMm, defPressurePa: Double?
    public let slug: String?
    public let zoom: Double
    public let nr, ns, nsr, p: Bool
    public let f: Bool
    public let h: Double?
}

// MARK: - Tzinfo
public struct Tzinfo: Codable {
    public let name, abbr: String
    public let dst: Bool
    public let offset: Double
}

// MARK: - Yesterday
public struct Yesterday: Codable {
    public let temp: Double
}
