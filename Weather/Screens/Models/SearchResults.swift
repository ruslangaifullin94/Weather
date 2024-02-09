//
//  SearchResults.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 28.12.2023.
//

import Foundation

public struct CitySearchModel: Hashable {
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, description: String, latitude: Double, longitude: Double) {
        self.name = name
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension CitySearchModel {
    init(location: FeatureMember) {
        self.name = location.geoObject.name
        self.description = location.geoObject.description
        let posString: String = location.geoObject.point.pos
        let components = posString.components(separatedBy: " ")
            if components.count == 2,
               let latitude = Double(components[1]),
               let longitude = Double(components[0]) {
                self.latitude = latitude
                self.longitude = longitude
            } else {
                self.latitude = 0.0
                self.longitude = 0.0
            }
    }
}

