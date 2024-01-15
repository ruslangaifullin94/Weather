//
//  DayCell.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 14.01.2024.
//

import UIKit

final class DayCell: UICollectionViewCell {
    
    private var loadImageTask: Task<Void, Never>?
    
    private var dayLabel = UILabel()
        .text2
    
    private var iconCondition = UIImageView()
    
    private var tempLabel = UILabel()
        .text3
    
    private lazy var tempStackView = UIStackView()
        .horizontal(spacing: LayoutConstants.minimumOffset)
        .views {
            iconCondition
            tempLabel
        }
    
    private var likeFeelIcon = UIImageView()
        .withHighHuggingPriority()
    
    private var likeFeelLabel = UILabel()
        .text2
        .with(\.text, setTo: "UI.Weather.LikeFeell".localized)
        .withHighCompressionPriority()
    
    private var likeFeelInfo = UILabel()
        .text4
        .withHighHuggingPriority()
    
    private lazy var feelLikeStack = UIStackView()
        .horizontal(spacing: LayoutConstants.singleOffset)
        .views {
            likeFeelIcon
            likeFeelLabel
            likeFeelInfo
        }
    
    private var windIcon = UIImageView()
        .with(\.image, setTo: .wind)
        .withHighHuggingPriority()
    
    private var windLabel = UILabel()
        .text2
        .with(\.text, setTo: "UI.Weather.Wind".localized)
        .withHighCompressionPriority()
    
    private var windInfo = UILabel()
        .text4
        .withHighHuggingPriority()
    
    private lazy var windStack = UIStackView()
        .horizontal(spacing: LayoutConstants.singleOffset)
        .views {
            windIcon
            windLabel
            windInfo
        }
    
    private var uvIcon = UIImageView()
        .with(\.image, setTo: .sun)
        .withHighHuggingPriority()
    
    private var uvLabel = UILabel()
        .text2
        .with(\.text, setTo: "UI.Weather.index".localized)
        .withHighCompressionPriority()
    
    private var uvInfo = UILabel()
        .text4
        .withHighHuggingPriority()
    
    private lazy var uvStack = UIStackView()
        .horizontal(spacing: LayoutConstants.singleOffset)
        .views {
            uvIcon
            uvLabel
            uvInfo
        }
    
    private var rainIcon = UIImageView()
        .with(\.image, setTo: .rain)
        .withHighHuggingPriority()
    
    private var rainLabel = UILabel()
        .text2
        .with(\.text, setTo: "UI.Weather.Rain".localized)
        .withHighCompressionPriority()
    
    private var rainInfo = UILabel()
        .text4
        .withHighHuggingPriority()
    
    private lazy var rainStack = UIStackView()
        .horizontal(spacing: LayoutConstants.singleOffset)
        .views {
            rainIcon
            rainLabel
            rainInfo
        }
    
    private var humidityIcon = UIImageView()
        .with(\.image, setTo: .cloudy)
        .withHighHuggingPriority()
    
    private var humidityLabel = UILabel()
        .text2
        .with(\.text, setTo: "UI.Weather.Humidity".localized)
        .withHighCompressionPriority()
    
    private var humidityInfo = UILabel()
        .text4
        .withHighHuggingPriority()
    
    private lazy var humidityStack = UIStackView()
        .horizontal(spacing: LayoutConstants.singleOffset)
        .views {
            humidityIcon
            humidityLabel
            humidityInfo
        }
    
    private var conditionLabel = UILabel()
        .text4
    
    private lazy var weatherStack = UIStackView()
        .vertical(spacing: LayoutConstants.singleOffset)
        .views {
            feelLikeStack
            windStack
            uvStack
            rainStack
            humidityStack
        }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        backgroundColor = .second
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        makeRoundCorners(.all, radius: LayoutConstants.smallRadius)
        addSubviews(dayLabel, tempStackView, conditionLabel, weatherStack)
        
        dayLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(LayoutConstants.singleOffset)
        }
        
        tempStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(LayoutConstants.singleOffset)
            $0.centerX.equalToSuperview()
        }
        conditionLabel.snp.makeConstraints {
            $0.top.equalTo(tempStackView.snp.bottom).offset(LayoutConstants.smallOffset)
            $0.centerX.equalTo(tempStackView)
        }
        
        weatherStack.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(LayoutConstants.singleOffset)
            $0.top.equalTo(conditionLabel.snp.bottom).offset(LayoutConstants.oneAndHalfOffset)
        }
        
        
    }
    
    private func configureIcon(for url: URL) {
        loadImageTask?.cancel()
        
        loadImageTask = Task { [weak self] in
            self?.iconCondition.image = nil
            do {
                try await self?.iconCondition.setImage(by: url)
                self?.iconCondition.contentMode = .scaleAspectFit
            } catch {
                self?.iconCondition.image = UIImage(systemName: "exclamationmark.icloud")
                self?.iconCondition.contentMode = .center
            }
        }
    }
    
}

extension DayCell: CollectionCell {
    func configuredCell(data: DayWeather) -> Self {
        configureIcon(for: data.icon)
        switch data.daytime {
        case .d:
            dayLabel.text = "День"
        case .n:
            dayLabel.text = "Ночь"
        }
        tempLabel.text = "\(data.tempAvg)"
        conditionLabel.text = data.condition
        likeFeelIcon.image = data.feelsLike > 0 ? .plusTemp : .frozenTemp
        likeFeelInfo.text = "\(data.feelsLike)"
        if let windSpeed = data.windSpeed, let windDir = data.windDir {
            windInfo.text = "\(windSpeed) \(windDir)"
            windStack.isHidden = false
        } else {
            windStack.isHidden = true
        }
        if let uvIndex = data.uvIndex {
            uvInfo.text = "\(uvIndex)"
            uvStack.isHidden = false
        } else {
            uvStack.isHidden = true
        }
        if let precProb = data.precProb {
            rainInfo.text = "\(precProb) %"
            rainStack.isHidden = false
        } else {
            rainStack.isHidden = true
        }
        humidityInfo.text = "\(data.humidity) %"
        return self
    }
}
