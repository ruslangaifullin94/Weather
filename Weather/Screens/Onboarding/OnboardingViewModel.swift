//
//  OnboardingViewModel.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 15.01.2024.
//

import Foundation

final class OnboardingViewModel {
    
    private weak var coordinator: OnboardingCoordinatorProtocol?
    
    init(coordinator: OnboardingCoordinatorProtocol?) {
        self.coordinator = coordinator
    }
    
    func switchFlow(accessLocation: Bool) {
        coordinator?.switchFlow(accessLocation: accessLocation)
    }
}
