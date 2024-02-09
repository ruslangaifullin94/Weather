// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchLocation = try? JSONDecoder().decode(SearchLocation.self, from: jsonData)

import Foundation

// MARK: - SearchLocation
struct SearchLocation: Codable {
     let response: Response
}

// MARK: - Response
struct Response: Codable {
    let geoObjectCollection: GeoObjectCollection

    enum CodingKeys: String, CodingKey {
        case geoObjectCollection = "GeoObjectCollection"
    }
}

// MARK: - GeoObjectCollection
struct GeoObjectCollection: Codable {
    let featureMember: [FeatureMember]
}

// MARK: - FeatureMember
struct FeatureMember: Codable {
    let geoObject: Geo

    enum CodingKeys: String, CodingKey {
        case geoObject = "GeoObject"
    }
}

// MARK: - GeoObject
struct Geo: Codable {
    let name, description: String
    let point: Point

    enum CodingKeys: String, CodingKey {
        case name, description
        case point = "Point"
    }
}


// MARK: - Point
struct Point: Codable {
    let pos: String
}

