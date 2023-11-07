//
//  LocationManager.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 28.10.2023.
//

import Foundation
import CoreLocation
import Combine

protocol LocationManagerProtocol: AnyObject {
    func getCurrentLocation(completion: @escaping (Result<UserLocation, LocationErrors>) -> Void)
}

final class LocationManager: LocationManagerProtocol {
    
//    private var remoteLocation: LocationDataSource
//    private var localLocation: LocationDataSource
//    
//    init(remoteLocation: LocationDataSource, localLocation: LocationDataSource) {
//        self.remoteLocation = remoteLocation
//        self.localLocation = localLocation
//    }
    
    func getCurrentLocation(completion: @escaping (Result<UserLocation, LocationErrors>) -> Void) {
       
    }
}

final class CurrentLocationManager: NSObject {
    
    static let shared = CurrentLocationManager()
    
    private var locationManager: CLLocationManager
    
    private var completion: ((CLLocation) -> Void)?
    
    private func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    private override init() {
        self.locationManager = CLLocationManager()
        super.init()
    }
    
    func getLocation(completion: @escaping ((_ location: CLLocation?) -> Void)) {
        self.completion = completion
        requestPermission()
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }
    
    
}

extension CurrentLocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .notDetermined:
                requestPermission()
            case .restricted:
                print("Запрещено через родительский контроль")
            case .denied:
                print("Вы запретили доступ к геолокации")
            case .authorizedAlways,.authorizedWhenInUse:
                manager.requestLocation()
            @unknown default:
                print("Не известный этап проверки")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            completion?(location)
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
