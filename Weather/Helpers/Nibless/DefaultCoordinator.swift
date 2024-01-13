//
//  DefaultCoordinator.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 27.10.2023.
//

import UIKit

class DefaultCoordinator {
    
    //MARK: - Properties
    
    var navigationController: UINavigationController
    weak var parentCoordinator: AnyObject?
    var childCoordinators: [CoordinatorProtocol] = []
    
    func createViewController() -> UIViewController {
        return UIViewController()
    }
    
    //MARK: - Life Cycles
    
    init(navigationController: UINavigationController, parentCoordinator: AnyObject?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
}
