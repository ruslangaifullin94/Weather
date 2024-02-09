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
    func requestLocation()
//    func getCurrentLocation() async throws -> UserLocation
//    func getCurrentLocation() throws -> UserLocation
}

final class LocationManager {

}

extension LocationManager: LocationManagerProtocol {
    func requestLocation() {
        CurrentLocationManager.shared.getLocation()
    }
}

final class CurrentLocationManager: NSObject {
    
    static let shared = CurrentLocationManager()
    
    private var locationManager: CLLocationManager
    
    private var completion: (() -> Void)?
        
    @Published var location: CLLocation = CLLocation()
    
    func accessLocation() -> Bool {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            return false
        case .authorizedAlways:
            return true
        case .authorizedWhenInUse:
            return true
        default:
            return false
        }

    }
        
    func requestPermission(completion: (() -> Void)?) {
        locationManager.requestWhenInUseAuthorization()
        self.completion = completion
    }
    
    private override init() {
        self.locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
    }
    
    func getLocation() {
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }
    
    
}

extension CurrentLocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("Запрещено через родительский контроль")
        case .denied:
            print("Вы запретили доступ к геолокации")
        case .authorizedAlways,.authorizedWhenInUse:
            getLocation()
            completion?()
        @unknown default:
            print("Не известный этап проверки")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        if let location = locations.last {
            self.location = location
            print("\(location.coordinate.latitude), \(location.coordinate.longitude)")

            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
