//
//  TabBarCoordinator.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 27.10.2023.
//

import UIKit

protocol TabBarCoordinatorProtocol: AnyObject {
    func switchFlow()
}

final class TabBarCoordinator {
    
    private weak var parentCoordinator: MainCoordinatorParentProtocol?
    
    private var tabBarController: UITabBarController
    private var childCoordinators: [CoordinatorProtocol] = []
    
    init(parentCoordinator: MainCoordinatorParentProtocol? = nil,
         tabBarController: UITabBarController) {
        self.parentCoordinator = parentCoordinator
        self.tabBarController = tabBarController
    }
    
    private func addChildCoordinator(coordinator: CoordinatorProtocol) {
        guard !self.childCoordinators.contains(where: {$0 === coordinator}) else {return}
        self.childCoordinators.append(coordinator)
    }
    
    private func removeChildCoordinator(coordinator: CoordinatorProtocol) {
        self.childCoordinators.removeAll(where: {$0 === coordinator})
    }
    
}

extension TabBarCoordinator: CoordinatorProtocol {
    
    func start() -> UIViewController {
        let tabBarController = UITabBarController()
        let homeScreenCoordinator = HomeScreenCoordinator(navigationController: UINavigationController(),
                                                          parentCoordinator: self)
        addChildCoordinator(coordinator: homeScreenCoordinator)
        let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController(),
                                                    parentCoordinator: self)
        addChildCoordinator(coordinator: profileCoordinator)
        tabBarController.viewControllers = [homeScreenCoordinator.start(), profileCoordinator.start()]
        self.tabBarController = tabBarController
        return self.tabBarController
    }
    
}

extension TabBarCoordinator: TabBarCoordinatorProtocol {
    func switchFlow() {
        parentCoordinator?.switchFlow()
    }
}
