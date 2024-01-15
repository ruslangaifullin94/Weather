//
//  HomeScreenCoordinator.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 27.10.2023.
//

import UIKit
import Combine

protocol HomeScreenCoordinatorProtocol: AnyObject {
    func didTapHourlyWeather(model: City)
    func didTapDaysWeather(model: City)
}

final class HomeScreenCoordinator: DefaultCoordinator {
    
    let locationManager = LocationManager()
    private var accessLocation: Bool = false
    private var subscription = Set<AnyCancellable>()
    
    override init(navigationController: UINavigationController, parentCoordinator: AnyObject?) {
        super.init(navigationController: navigationController, parentCoordinator: parentCoordinator)
        checkAccessLocation()
    }
    
    func checkAccessLocation() {
        CurrentLocationManager.shared.requestPermission()
        CurrentLocationManager.shared.$accessLocation
            .sink { [weak self] access in
                self?.accessLocation = access
            }.store(in: &subscription)
    }
    
    override func createViewController() -> UIViewController {
        
        let networkManager = CoreNetworkManager()
        let mapper = CoreMapper()
        let weatherApiService = WeatherApiService(locationManager: locationManager, 
                                                  networkManager: networkManager,
                                                  mapper: mapper)
        let userLocation = CoreDataHandler.shared.fetchAllUserLocations()
        let pageViewModel = PageViewModel(locations: userLocation, weatherApiService: weatherApiService, coordinator: self, accessLocation: accessLocation)
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
