//
//  City.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 28.12.2023.
//

import Foundation
import CommonCoreService

struct City: Hashable {
    let name: String
    let weather: WeatherCity
    
    init(name: String, weather: WeatherCity) {
        self.name = name
        self.weather = weather
    }
}
extension City {
    init(cityInfo: WeatherCodable) {
        self.name = cityInfo.geoObject.locality?.name ?? "No Name"
        self.weather = .init(weather: cityInfo)
    }
}

struct WeatherCity: Hashable {
    let fact: FactWeather
    let forecasts: [ForecastsWeather]
    init(fact: FactWeather, forecasts: [ForecastsWeather]) {
        self.fact = fact
        self.forecasts = forecasts
    }
}

extension WeatherCity {
    init(weather: WeatherCodable) {
        self.fact = FactWeather(fact: weather.fact)
        self.forecasts = weather.forecasts.map { ForecastsWeather(weather: $0) }
    }
}

struct FactWeather: Hashable {
    let temp: Int
    let feelLike: Int
    let condition: String
    let icon: URL?
    
    init(temp: Int, feelLike: Int, condition: String, icon: URL?) {
        self.temp = temp
        self.feelLike = feelLike
        self.condition = condition
        self.icon = icon
    }
}

extension FactWeather {
    init(fact: Fact) {
        self.temp = fact.temp
        self.feelLike = fact.feelsLike
        self.condition = getConditionString(condition: fact.condition)
        self.icon = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(fact.icon).svg")
    }
}


struct ForecastsWeather: Hashable {
    let date: Date
    let dateTs: Double
    let riseBegin: String
    let setEnd: String
    let moonCode: Double
    let parts: PartsWeather
    let hours: [WeatherHour]
    
    init(date: Date,
         dateTs: Double,
         riseBegin: String,
         setEnd: String,
         moonCode: Double,
         parts: PartsWeather,
         hours: [WeatherHour]
    ) {
        self.date = date
        self.dateTs = dateTs
        self.riseBegin = riseBegin
        self.setEnd = setEnd
        self.moonCode = moonCode
        self.parts = parts
        self.hours = hours
    }
}

extension ForecastsWeather {
    init(weather: Forecast) {
        self.date = weather.date
        self.dateTs = weather.dateTs
        self.riseBegin = weather.riseBegin
        self.setEnd = weather.setEnd
        self.moonCode = weather.moonCode
        self.parts = PartsWeather(weatherParts: weather.parts)
        self.hours = weather.hours.map { WeatherHour(weatherHour: $0) }
    }
}


struct PartsWeather: Hashable {
    let day: DayWeather
    let night: DayWeather
    
    init(day: DayWeather, night: DayWeather) {
        self.day = day
        self.night = night
    }
}

extension PartsWeather {
    init(weatherParts: Parts) {
        self.day = DayWeather(day: weatherParts.day)
        self.night = DayWeather(day: weatherParts.night)
    }
}

struct DayWeather: Hashable {
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
    let precProb: Int?
    let precPeriod: Double?
    let cloudness: Double
    let precType: Double?
    let precStrength: Double?
    let icon: URL
    let condition: String
    let uvIndex: Int?
    let feelsLike: Int
    let daytime: PurpleDaytime
    let polar: Bool
    let freshSnowMm: Double?
    let temp: Int?
    
    init(
//        source: String,
         tempMin: Int,
         tempAvg: Int,
         tempMax: Int,
         windSpeed: Double?,
         windGust: Double?,
         windDir: String?,
         pressureMm: Double?,
         pressurePa: Double?,
         humidity: Int,
         soilTemp: Double?,
         soilMoisture: Double?,
         precMm: Double?,
         precProb: Int?,
         precPeriod: Double?,
         cloudness: Double,
         precType: Double?,
         precStrength: Double?,
         icon: URL,
         condition: String,
         uvIndex: Int?,
         feelsLike: Int,
         daytime: PurpleDaytime,
         polar: Bool,
         freshSnowMm: Double?,
         temp: Int?
    ) {
//        self.source = source
        self.tempMin = tempMin
        self.tempAvg = tempAvg
        self.tempMax = tempMax
        self.windSpeed = windSpeed
        self.windGust = windGust
        self.windDir = windDir
        self.pressureMm = pressureMm
        self.pressurePa = pressurePa
        self.humidity = humidity
        self.soilTemp = soilTemp
        self.soilMoisture = soilMoisture
        self.precMm = precMm
        self.precProb = precProb
        self.precPeriod = precPeriod
        self.cloudness = cloudness
        self.precType = precType
        self.precStrength = precStrength
        self.icon = icon
        self.condition = condition
        self.uvIndex = uvIndex
        self.feelsLike = feelsLike
        self.daytime = daytime
        self.polar = polar
        self.freshSnowMm = freshSnowMm
        self.temp = temp
    }
}
extension DayWeather {
    init(day: Day) {
//        self.source = day.source
        self.tempMin = day.tempMin
        self.tempAvg = day.tempAvg
        self.tempMax = day.tempMax
        self.windSpeed = day.windSpeed
        self.windGust = day.windGust
        self.windDir = day.windDir
        self.pressureMm = day.pressureMm
        self.pressurePa = day.pressurePa
        self.humidity = day.humidity
        self.soilTemp = day.soilTemp
        self.soilMoisture = day.soilMoisture
        self.precMm = day.precMm
        self.precProb = day.precProb
        self.precPeriod = day.precPeriod
        self.cloudness = day.cloudness
        self.precType = day.precType
        self.precStrength = day.precStrength
        self.icon = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(day.icon).svg")!
        self.condition = getConditionString(condition: day.condition)
        self.uvIndex = day.uvIndex
        self.feelsLike = day.feelsLike
        self.daytime = day.daytime
        self.polar = day.polar
        self.freshSnowMm = day.freshSnowMm
        self.temp = day.temp
    }
}

struct WeatherHour: Hashable {
    let hour: String
    let temp: Int
    let feelsLike: Int
    let condition: String
    let windSpeed: Double
    let precStrength: Double
    let cloudness: Double
    let icon: URL
    let precProb: Int
    let humidity: Int
    
    init(hour: String, temp: Int, feelsLike: Int, condition: String, windSpeed: Double, precStrength: Double, cloudness: Double, icon: URL, precProb: Int, humidity: Int) {
        self.hour = hour
        self.temp = temp
        self.feelsLike = feelsLike
        self.condition = condition
        self.windSpeed = windSpeed
        self.precStrength = precStrength
        self.cloudness = cloudness
        self.icon = icon
        self.precProb = precProb
        self.humidity = humidity
    }
}

extension WeatherHour {
    init(weatherHour: Hour) {
        self.hour = weatherHour.hour
        self.temp = weatherHour.temp
        self.feelsLike = weatherHour.feelsLike
        self.condition = weatherHour.condition
        self.windSpeed = weatherHour.windSpeed ?? 0
        self.precStrength = weatherHour.precStrength
        self.cloudness = weatherHour.cloudness
        self.icon = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(weatherHour.icon).svg")!
        self.precProb = weatherHour.precProb
        self.humidity = weatherHour.humidity
    }
}
