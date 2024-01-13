//
//  LocationDataSource.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 28.10.2023.
//

import Foundation
import Combine

protocol LocationDataSource {
    func getLocation() -> AnyPublisher<UserLocation, LocationErrors>
    func saveLocation(_ location: UserLocation)
}

final class LocalLocationDataSource: LocationDataSource {
    
    private let queue = DispatchQueue(label: String(describing: LocalLocationDataSource.self))
    
    private let locationDataStorage: LocationDataManagerProtocol
    
    init(locationDataStorage: LocationDataManagerProtocol) {
        self.locationDataStorage = locationDataStorage
    }
    
    func getLocation() -> AnyPublisher<UserLocation, LocationErrors> {
        Future { [locationDataStorage] promise in
            if let location = locationDataStorage.readLocation().first {
                promise(.success(location))
            }
        }.eraseToAnyPublisher()
    }
    
    func saveLocation(_ location: UserLocation) {
        queue.async { [locationDataStorage] in
            locationDataStorage.deleteLocation()
            locationDataStorage.saveLocation(location)
        }
    }
}


//final class RemoteLocaationDataSource: LocationDataSource {
//    
//    
//    
//    func getLocation() -> AnyPublisher<UserLocation, LocationErrors> {
//        Future { promise in
//                if let location = async CurrentLocationManager.shared.getLocation() {
//                    promise(.success(location))
//                } else {
//                    promise(.failure(LocationErrors.locationNotFound))
//                }
//        }.eraseToAnyPublisher()
//    }
//    
//    func saveLocation(_ location: UserLocation) { }
//    
//    
//}
