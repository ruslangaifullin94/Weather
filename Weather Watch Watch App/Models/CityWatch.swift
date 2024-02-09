//
//  CityWatch.swift
//  Weather Watch Watch App
//
//  Created by Руслан Гайфуллин on 08.02.2024.
//

import Foundation

struct CityWatch: Hashable, Identifiable {
    
    var id: String {
        return name
    }
    
    var name: String
    var weather: WeatherCityWatch
}

extension CityWatch {
    init(cityInfo: WeatherCodable) {
        self.name = cityInfo.geoObject.locality?.name ?? "No Name"
        self.weather = .init(weather: cityInfo)
    }
}

struct WeatherCityWatch: Hashable {
    let fact: FactWeatherWatch
    init(fact: FactWeatherWatch) {
        self.fact = fact
    }
}

extension WeatherCityWatch {
    init(weather: WeatherCodable) {
        self.fact = FactWeatherWatch(fact: weather.fact)
    }
}

struct FactWeatherWatch: Hashable {
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

extension FactWeatherWatch {
    init(fact: Fact) {
        self.temp = fact.temp
        self.feelLike = fact.feelsLike
        self.condition = getConditionString(condition: fact.condition)
        self.icon = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(fact.icon).svg")
    }
}
//
//public func getConditionString(condition: String) -> String {
//    return "Weather.Condition.\(condition)".localized
//}
