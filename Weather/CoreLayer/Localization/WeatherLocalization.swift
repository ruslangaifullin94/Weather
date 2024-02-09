//
//  Localization.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 01.02.2024.
//

import Foundation
public final class WeatherLocalization {
    
    static let shared = WeatherLocalization()
    
    /// Текущий язык приложения.
    public var currentLanguage: Language {
        return getCurrentLanguage()
    }
    
    private func getCurrentLanguage() -> Language {
        let currentStringAppLanguage = Bundle.main.preferredLocalizations.first
        let currentAppLanguage = currentStringAppLanguage.flatMap { Language(isoCode: $0) }
        guard let language = currentAppLanguage else {
            assertionFailure("Неподдерживаемый язык приложения: \(String(describing: currentStringAppLanguage))")
            return .ru
        }
        return language
    }
    
}

extension WeatherLocalization.Language {
   public init?(isoCode: String) {
        let langFromDict = WeatherLocalization.isoCodesLangugesDictionary[isoCode]
        let langRaw = WeatherLocalization.Language(rawValue: isoCode)
        guard let language = langFromDict ?? langRaw  else {
            return nil
        }
        self = language
    }
}

extension WeatherLocalization {
    
    /// Массив iso-кодов поддерживаемых языков
    static let supportedLanguages = isoCodesLangugesDictionary.map { $0.key }
    
    static let isoCodesLangugesDictionary: [String: WeatherLocalization.Language] =
    [
        "en": .en,
        "ru": .ru
    ]
    
    /// Языки, которые поддерживает приложение.
    public enum Language: String, CaseIterable {
        case en = "en_US"
        case ru = "ru_RU"
    }
}

func getConditionString(condition: String) -> String {
    return "Weather.Condition.\(condition)".localized
}
