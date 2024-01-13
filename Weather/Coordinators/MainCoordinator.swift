//
//  MainCoordinator.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 08.10.2023.
//

import Foundation
import UIKit


protocol MainCoordinatorParentProtocol: AnyObject {
    func switchFlow()
}

final class MainCoordinator {
    
    // MARK: - Private properties
    
    private var rootViewController: UIViewController
    private var childsCoordinators: [CoordinatorProtocol] = []
    
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
    
    private func setLoginCoordinator() {
        
    }
    
}

extension MainCoordinator: MainCoordinatorParentProtocol {
    func switchFlow() {
        ()
    }
}


extension MainCoordinator: CoordinatorProtocol {
    
    func start() -> UIViewController {
        var coordinator: CoordinatorProtocol
        coordinator = homeScreenCoordinator()
        addChildCoordinator(coordinator: coordinator)
        return coordinator.start()
    }
    
}
