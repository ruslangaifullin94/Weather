//
//  HomeScreenCoordinator.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 27.10.2023.
//

import UIKit

final class HomeScreenCoordinator: DefaultCoordinator {
    
    override func createViewController() -> UIViewController {
        let locationManager = LocationManager()
        let homeViewModel = HomeViewModel(locationManager: locationManager)
        let viewController = HomeViewController(viewModel: homeViewModel)
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = UITabBarItem(title: "UI.HomeScren.Title".localized,
                                                image: UIImage(systemName: "location.circle"),
                                                tag: 0)
        self.navigationController = navController
        return navigationController
    }
}

extension HomeScreenCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createViewController()
    }
}
