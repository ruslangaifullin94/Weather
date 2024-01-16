//
//  OnboardingCoordinator.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 15.01.2024.
//

import UIKit

protocol OnboardingCoordinatorProtocol: AnyObject {
    func switchFlow(accessLocation: Bool)
}

final class OnboardingCoordinator: DefaultCoordinator {
    
    override func createViewController() -> UIViewController {
        let viewModel = OnboardingViewModel(coordinator: self)
        let viewController  = OnboardingViewController(viewModel: viewModel)
        return viewController
    }
}

extension OnboardingCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createViewController()
    }
}

extension OnboardingCoordinator: OnboardingCoordinatorProtocol {
    func switchFlow(accessLocation: Bool) {
        if accessLocation {
            CurrentLocationManager.shared.requestPermission { [parentCoordinator] in
                UserDefaults.standard.set(true, forKey: "launchAppBefore")
                (parentCoordinator as? MainCoordinatorParentProtocol)?.switchToNextFlow(from: self)
            }
        } else {
            UserDefaults.standard.set(true, forKey: "launchAppBefore")
            (parentCoordinator as? MainCoordinatorParentProtocol)?.switchToNextFlow(from: self)
        }
        
    }
}
