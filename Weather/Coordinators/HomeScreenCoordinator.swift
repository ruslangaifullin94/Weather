//
//  HomeScreenCoordinator.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 27.10.2023.
//

import UIKit

protocol HomeScreenCoordinatorProtocol: AnyObject {
    func didTapHourlyWeather(model: City)
    func didTapDaysWeather(model: City)
}

final class HomeScreenCoordinator: DefaultCoordinator {
    
    let locationManager = LocationManager()
    
    override func createViewController() -> UIViewController {
        
        let networkManager = CoreNetworkManager()
        let mapper = CoreMapper()
        let weatherApiService = WeatherApiService(locationManager: locationManager, 
                                                  networkManager: networkManager,
                                                  mapper: mapper)
        var userLocation = CoreDataHandler.shared.fetchAllUserLocations()
        if userLocation.count == 0 {
            userLocation.append(UserLocation(longitude: 0, latitude: 0))
        }
        let pageViewModel = PageViewModel(locations: userLocation, weatherApiService: weatherApiService, coordinator: self)
        let viewController = PageViewController(viewModel: pageViewModel)
        let navController = UINavigationController(rootViewController: viewController)
        self.navigationController = navController
        return navigationController
    }
}

extension HomeScreenCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createViewController()
    }
}

extension HomeScreenCoordinator: HomeScreenCoordinatorProtocol {
    func didTapHourlyWeather(model: City) {
        ()
    }
    
    func didTapDaysWeather(model: City) {
        let viewModel = DayViewModel(forecast: model)
        let viewController = DayViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
