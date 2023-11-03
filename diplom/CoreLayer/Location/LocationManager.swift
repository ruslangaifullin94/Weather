//
//  LocationManager.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 28.10.2023.
//

import Foundation
import CoreLocation
import Combine

protocol LocationManagerProtocol {
    func getCurrentLocation() -> AnyPublisher<UserLocation, LocationErrors>
}

final class LocationManager: LocationManagerProtocol {
    
    private var remoteLocation: LocationDataSource
    private var localLocation: LocationDataSource
    
    init(remoteLocation: LocationDataSource, localLocation: LocationDataSource) {
        self.remoteLocation = remoteLocation
        self.localLocation = localLocation
    }
    
    func getCurrentLocation() -> AnyPublisher<UserLocation, LocationErrors> {
        Publishers.MergeMany(
            localLocation.getLocation(),
            remoteLocation.getLocation()
            .handleEvents(receiveSubscription: localLocation.saveLocation(_:))
            .eraseToAnyPublisher()
        ).receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
}

final class CurrentLocationManager {
    
    static let shared = CurrentLocationManager()
    
    private var locationManager = CLLocationManager()
    
    func getLocation() -> UserLocation? {
        guard let location = locationManager.location else {
            return nil
        }
        let userLocation = UserLocation(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude)
        return userLocation
    }
    
    
}
