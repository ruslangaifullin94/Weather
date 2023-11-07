//
//  ProfileCoordinator.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 27.10.2023.
//

import UIKit


final class ProfileCoordinator: DefaultCoordinator {
    
    override func createViewController() -> UIViewController {
        let viewController = ProfileViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = UITabBarItem(title: "UI.ProfileScren.Title".localized,
                                                image: UIImage(systemName: "person.crop.circle"),
                                                tag: 1)
        self.navigationController = navController
        return navigationController
    }
    
}


extension ProfileCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createViewController()
    }
}
