//
//  PageViewModel.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 11.01.2024.
//

import Foundation
import Combine

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
        case updatePage(numberOfPage: Int, title: String)
        case swipePage(currentIndex: Int)
        case cancelSearch
    }
    
    @Published var state: State = .initial
    
    private weak var coordinator: HomeScreenCoordinatorProtocol?
    private var locations: [UserLocation]
    
    var weatherApiService: WeatherApiServiceProtocol
    
    lazy var viewControllers: [HomeViewController] = []
    
    init(locations: [UserLocation],
         weatherApiService: WeatherApiServiceProtocol,
         coordinator: HomeScreenCoordinatorProtocol?) 
    {
        self.locations = locations
        self.weatherApiService = weatherApiService
        self.coordinator = coordinator
        self.viewControllers = locations.enumerated().map { index, location in
            let forCurrentLocation = index == 0
            let viewModel = HomeViewModel(weatherApiService: weatherApiService, 
                                          userLocation: location,
                                          forCurrentLocation: forCurrentLocation)
            viewModel.delegate = self
            let viewController = HomeViewController(viewModel: viewModel)
            return viewController
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
        let viewController = HomeViewController(viewModel: viewModel)
        viewControllers.append(viewController)
        state = .updatePage(numberOfPage: viewControllers.count, title: title)
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
