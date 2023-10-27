//
//  MainCoordinator.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 08.10.2023.
//

import Foundation
import UIKit

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
}


extension MainCoordinator: CoordinatorProtocol {
    
    func start() -> UIViewController {
        <#code#>
    }
    
}
