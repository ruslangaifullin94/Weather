//
//  HourCell.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 16.01.2024.
//

import UIKit

final class HourCell: UICollectionViewCell {
    
    private lazy var dateLabel = UILabel()
        .text4
    
    private var timeLabel = UILabel()
        .text2
        .withTextColor(.secondText)
    
    private var tempLabel = UILabel()
        .text4
    
    private var likeFeelIcon = UIImageView()
        .withHighHuggingPriority()
    
    private var likeFeelLabel = UILabel()
        .text2
        .with(\.text, setTo: "UI.Weather.LikeFeell".localized)
        .withHighCompressionPriority()
    
    private var likeFeelInfo = UILabel()
        .text2
        .withTextColor(.secondText)
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
        .text2
        .withTextColor(.secondText)
        .withHighHuggingPriority()
    
    private lazy var windStack = UIStackView()
        .horizontal(spacing: LayoutConstants.singleOffset)
        .views {
            windIcon
            windLabel
            windInfo
        }
    
    private var rainIcon = UIImageView()
        .with(\.image, setTo: .rain)
        .withHighHuggingPriority()
    
    private var rainLabel = UILabel()
        .text2
        .with(\.text, setTo: "UI.Weather.Rain".localized)
        .withHighCompressionPriority()
    
    private var rainInfo = UILabel()
        .text2
        .withTextColor(.secondText)
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
        .text2
        .withTextColor(.secondText)
        .withHighHuggingPriority()
    
    private lazy var humidityStack = UIStackView()
        .horizontal(spacing: LayoutConstants.singleOffset)
        .views {
            humidityIcon
            humidityLabel
            humidityInfo
        }
    
    private lazy var weatherStack = UIStackView()
        .vertical(spacing: LayoutConstants.singleOffset)
        .views {
            feelLikeStack
            windStack
            rainStack
            humidityStack
        }
    
    private var line = UIView()
        .withBackgroundColor(.main)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubviews(dateLabel, timeLabel, tempLabel, weatherStack, line)
        
        dateLabel.snp.makeConstraints {
            $0.left.top.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalTo(dateLabel.snp.bottom).offset(LayoutConstants.halfOffset)
        }
        
        tempLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(LayoutConstants.quarterOffset)
            $0.top.equalTo(timeLabel.snp.bottom).offset(LayoutConstants.halfOffset)
        }
        
        weatherStack.snp.makeConstraints {
            $0.left.equalTo(timeLabel.snp.right).offset(LayoutConstants.smallOffset)
            $0.right.equalToSuperview()
            $0.top.equalTo(timeLabel)
        }
        
        line.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
extension HourCell: CollectionCell {
   
    func configuredCell(data: WeatherHour) -> Self {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E dd/MM"
        dateLabel.text = dateFormatter.string(from: Date())
        timeLabel.text = "\(data.hour):00"
        tempLabel.text = "\(data.temp)"
        likeFeelInfo.text = "\(data.feelsLike)"
        windInfo.text = "\(data.windSpeed)"
        rainInfo.text = "\(data.precProb) %"
        humidityInfo.text = "\(data.humidity) %"
        return self
    }
    
}
