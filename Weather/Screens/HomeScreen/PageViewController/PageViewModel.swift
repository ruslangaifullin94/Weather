//
//  PageViewModel.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 11.01.2024.
//

import Foundation
import Combine
import UIKit

protocol PageViewModelDelegate: AnyObject {
    func updateTitle(title: String)
    func didSelectHourlyWeather(model: City?)
    func didSelectDaysWeather(model: City?)
}

final class PageViewModel {
    
    enum State {
        case initial
        case loaded(title: String)
        case showSearch
        case updatePage(numberOfPage: Int, title: String, accessLocation: Bool)
        case swipePage(currentIndex: Int)
        case cancelSearch
    }
    
    @Published var state: State = .initial
    
    private weak var coordinator: HomeScreenCoordinatorProtocol?
    private var locations: [UserLocation]
    private var accessLocation: Bool
    
    var weatherApiService: WeatherApiServiceProtocol
    
    lazy var viewControllers: [UIViewController] = []
    
    init(locations: [UserLocation],
         weatherApiService: WeatherApiServiceProtocol,
         coordinator: HomeScreenCoordinatorProtocol?,
         accessLocation: Bool)
    {
        self.locations = locations
        self.weatherApiService = weatherApiService
        self.coordinator = coordinator
        self.accessLocation = accessLocation
        self.viewControllers = setViewControllers()
    }
    
    private func setViewControllers() -> [UIViewController] {
        if accessLocation {
            if locations.isEmpty {
                let userLocation = UserLocation(longitude: 0, latitude: 0)
                let viewModel = HomeViewModel(weatherApiService: weatherApiService,
                                              userLocation: userLocation,
                                              forCurrentLocation: true)
                viewModel.delegate = self
                let viewController = HomeViewController(viewModel: viewModel)
                return [viewController]
            } else {
                let userLocation = UserLocation(longitude: 0, latitude: 0)
                locations.insert(userLocation, at: 0)
                return locations.enumerated().map { index, location in
                    let forCurrentLocation = index == 0
                    let viewModel = HomeViewModel(weatherApiService: weatherApiService,
                                                  userLocation: location,
                                                  forCurrentLocation: forCurrentLocation)
                    viewModel.delegate = self
                    let viewController = HomeViewController(viewModel: viewModel)
                    return viewController
                }
            }
        } else {
            if locations.isEmpty {
                let emptyViewController = EmptyViewController()
                return [emptyViewController]
            } else {
                return locations.enumerated().map { index, location in
                    let viewModel = HomeViewModel(weatherApiService: weatherApiService,
                                                  userLocation: location,
                                                  forCurrentLocation: false)
                    viewModel.delegate = self
                    let viewController = HomeViewController(viewModel: viewModel)
                    return viewController
                }
            }
        }
    }
    
    private func saveLocations(userLocation: UserLocation) {
        CoreDataHandler.shared.saveUserLocation(userLocation)
    }
}

extension PageViewModel {
    func addLocation(location: UserLocation, title: String) {
        saveLocations(userLocation: location)
        let viewModel = HomeViewModel(weatherApiService: weatherApiService, userLocation: location, forCurrentLocation: false)
        viewModel.delegate = self
        let viewController = HomeViewController(viewModel: viewModel)
        if accessLocation {
            viewControllers.append(viewController)
            state = .updatePage(numberOfPage: viewControllers.count, title: title, accessLocation: accessLocation)
        } else {
            viewControllers.append(viewController)
            state = .updatePage(numberOfPage: viewControllers.count, title: title, accessLocation: accessLocation)
        }
    }
    
    func didTapAddButton() {
        state = .showSearch
    }
    
    func didCancelSearch() {
        state = .cancelSearch
    }
    
    func swipe(index: Int) {
        state = .swipePage(currentIndex: index)
    }
    
}

extension PageViewModel: PageViewModelDelegate {
    
    func didSelectHourlyWeather(model: City?) {
        guard let model else { return }
        coordinator?.didTapHourlyWeather(model: model)
    }
    
    func didSelectDaysWeather(model: City?) {
        guard let model else { return }
        coordinator?.didTapDaysWeather(model: model)
    }
    
    func updateTitle(title: String) {
        state = .loaded(title: title)
    }
    
}
