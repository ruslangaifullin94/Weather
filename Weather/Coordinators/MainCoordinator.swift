//
//  MainCoordinator.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 08.10.2023.
//

import Foundation
import UIKit


protocol MainCoordinatorParentProtocol: AnyObject {
    func switchToNextFlow(from currentCoodinator: CoordinatorProtocol)
}

final class MainCoordinator {
    
    // MARK: - Private properties
    
    private var rootViewController: UIViewController
    private var childsCoordinators: [CoordinatorProtocol] = []
    private var firstLaunch: Bool = true
    
    // MARK: - Initialise
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    private func addChildCoordinator(coordinator: CoordinatorProtocol) {
        guard !childsCoordinators.contains(where: {$0 === coordinator}) else { return }
        childsCoordinators.append(coordinator)
    }
    
    private func removeChildCoordinator(coordinator: CoordinatorProtocol) {
        childsCoordinators.removeAll(where: {$0 === coordinator})
    }
    
    private func setFlow(to newViewController: UIViewController) {
        rootViewController.addChild(newViewController)
        newViewController.view.frame = rootViewController.view.frame
        rootViewController.view.addSubview(newViewController.view)
        newViewController.didMove(toParent: rootViewController)
    }
    
    private func homeScreenCoordinator() -> CoordinatorProtocol {
        let homeScreenCoordinator = HomeScreenCoordinator(navigationController: UINavigationController(),
                                                          parentCoordinator: self)
        return homeScreenCoordinator
    }
    
    private func setOnboardingCoordinator() -> CoordinatorProtocol {
        let onboardingCoordinator = OnboardingCoordinator(navigationController: UINavigationController(),
                                                          parentCoordinator: self)
        
        return onboardingCoordinator
    }
    
    private func switchFlow(to newViewController: UIViewController) {
        rootViewController.children[0].willMove(toParent: nil)
        rootViewController.children[0].navigationController?.isNavigationBarHidden = true
        rootViewController.addChild(newViewController)
        newViewController.view.frame = rootViewController.view.bounds
        
        rootViewController.transition(
            from: rootViewController.children[0],
            to: newViewController,
            duration: 0.6,
            options: [.transitionFlipFromRight],
            animations: {}
        ) {_ in
            self.rootViewController.children[0].removeFromParent()
            newViewController.didMove(toParent: self.rootViewController)
        }
    }
    
    private func switchCoordinators(from oldCoordinator: CoordinatorProtocol, to newCoordinator: CoordinatorProtocol) {
        addChildCoordinator(coordinator: newCoordinator)
        switchFlow(to: newCoordinator.start())
        removeChildCoordinator(coordinator: oldCoordinator)
    }
}

extension MainCoordinator: MainCoordinatorParentProtocol {
    func switchToNextFlow(from currentCoodinator: CoordinatorProtocol) {
            switch currentCoodinator {
            case let oldCoordinator as OnboardingCoordinator:
                let newCoordinator = self.homeScreenCoordinator()
                self.switchCoordinators(from: oldCoordinator, to: newCoordinator)

            default:
                print("Ошибка! func switchToNextFlow in MainCoordinator")
            }
        }
}


extension MainCoordinator: CoordinatorProtocol {
    
    func start() -> UIViewController {
        firstLaunch = UserDefaults.standard.bool(forKey: "launchAppBefore")
        var coordinator: CoordinatorProtocol
        coordinator = firstLaunch ? homeScreenCoordinator() : setOnboardingCoordinator()
        addChildCoordinator(coordinator: coordinator)
        setFlow(to: coordinator.start())
        return rootViewController
    }
    
}
