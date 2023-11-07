//
//  HomeViewModel.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 28.10.2023.
//

import Foundation
import Combine

final class HomeViewModel {
    
    enum State {
        case loading
        case loaded(location: UserLocation)
        case error
    }
    
    private weak var locationManager: LocationManagerProtocol?
    
    init(locationManager: LocationManagerProtocol) {
        self.locationManager = locationManager
    }
    
    @Published var state: State = .loading
    
    func getLocation() {
        Task {
            do {
                if let userLocation = try await locationManager?.getCurrentLocation() {
                    state = .loaded(location: try userLocation.get())
                }
            } catch {
                state = .error
            }
        }
    }
}
