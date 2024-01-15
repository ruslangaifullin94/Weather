//
//  OnboardingViewController.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 15.01.2024.
//

import UIKit

final class OnboardingViewController: NiblessViewController {
    
    private var imageView = UIImageView()
        .with(\.image, setTo: .onboarding)
    
    private var mainLabel = UILabel()
        .text1
        .with(\.text, setTo: "UI.Onboarding.main".localized)
        .with(\.textAlignment, setTo: .center)
    
    private var descLabel = UILabel()
        .text2
        .with(\.text, setTo: "UI.Onboarding.description".localized)
        .with(\.textAlignment, setTo: .center)

    private var settingsLabel = UILabel()
        .text2
        .with(\.text, setTo: "UI.Onboarding.settings".localized)
        .with(\.textAlignment, setTo: .center)
    
    private lazy var authLocationButton = UIButton()
        .with {
            $0.setTitle("UI.Onboarding.Button.Ok".localized, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .buttonOkNormal
            if $0.isSelected {
                $0.backgroundColor = .buttonOkSelect
            }
            $0.makeRoundCorners(.all, radius: LayoutConstants.mediumRadius)
            $0.addTarget(self, action: #selector(didTapAuthLocation), for: .touchUpInside)
        }
    
    private lazy var deniedLocationButton = UIButton()
        .with {
            $0.setTitle("UI.Onboarding.Button.Dont".localized, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .clear
            $0.addTarget(self, action: #selector(didTapDontAuthLocations), for: .touchUpInside)
        }
    
    private var viewModel: OnboardingViewModel
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "mainColor")
        view.addSubviews(imageView, mainLabel, descLabel, settingsLabel, authLocationButton, deniedLocationButton)
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(148)
            $0.centerX.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(LayoutConstants.oneAndHalfOffset)
            $0.left.right.equalToSuperview().inset(LayoutConstants.singleOffset)
            $0.centerX.equalToSuperview()
        }
        
        descLabel.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(LayoutConstants.oneAndHalfOffset)
            $0.left.right.equalToSuperview().inset(LayoutConstants.singleOffset)
            $0.centerX.equalToSuperview()
        }
        
        settingsLabel.snp.makeConstraints {
            $0.top.equalTo(descLabel.snp.bottom).offset(LayoutConstants.oneAndHalfOffset)
            $0.left.right.equalToSuperview().inset(LayoutConstants.singleOffset)
            $0.centerX.equalToSuperview()
        }
        
        authLocationButton.snp.makeConstraints {
            $0.top.equalTo(settingsLabel.snp.bottom).offset(LayoutConstants.oneAndHalfOffset)
            $0.left.right.equalToSuperview().inset(LayoutConstants.singleOffset)
            $0.height.equalTo(40)
        }
        
        deniedLocationButton.snp.makeConstraints {
            $0.top.equalTo(authLocationButton.snp.bottom).offset(LayoutConstants.oneAndHalfOffset)
            $0.left.right.equalToSuperview().inset(LayoutConstants.singleOffset)
            $0.height.equalTo(21)
        }
    }
    
    @objc private func didTapAuthLocation() {
        viewModel.switchFlow(accessLocation: true)
    }
    
    @objc private func didTapDontAuthLocations() {
        viewModel.switchFlow(accessLocation: false)
    }
}
