//
//  WeatherDayCell.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 27.12.2023.
//

import UIKit
import SnapKit

final class WeatherDayCell: UICollectionViewCell {
    
    private var loadImageTask: Task<Void, Never>?
    
    private let conditionLabel = UILabel()
        .text1
        .withTextColor(.mainText)
    
    private let dateLabel = UILabel()
        .text1
        .withTextColor(.secondText)
    
    private let precLabel = UILabel()
        .text2
        .withTextColor(.main)
    
    private let tempLabel = UILabel()
        .text4
        .with(\.textColor, setTo: .black)
    
    private let iconView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor(named: "secondColor")
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        makeRoundCorners(.all, radius: LayoutConstants.smallRadius)
        addSubviews(iconView, precLabel, conditionLabel, tempLabel, dateLabel)
        
        iconView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(LayoutConstants.minimumOffset)
            $0.left.equalToSuperview().inset(LayoutConstants.minimumOffset)
            $0.size.equalTo(20)
        }
        
        precLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(LayoutConstants.quarterOffset)
            $0.centerY.equalTo(iconView.snp.centerY)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(LayoutConstants.minimumOffset)
            $0.left.equalToSuperview().inset(LayoutConstants.minimumOffset)
        }
        
        conditionLabel.snp.makeConstraints {
            $0.left.equalTo(dateLabel.snp.right).offset(LayoutConstants.smallOffset)
            $0.centerY.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints {
            $0.right.equalToSuperview().inset(LayoutConstants.minimumOffset)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func configureIcon(for url: URL) {
        loadImageTask?.cancel()
        
        loadImageTask = Task { [weak self] in
            self?.iconView.image = nil
            do {
                try await self?.iconView.setImage(by: url)
                self?.iconView.contentMode = .scaleAspectFit
            } catch {
                self?.iconView.image = UIImage(systemName: "exclamationmark.icloud")
                self?.iconView.contentMode = .center
            }
        }
    }
}

extension WeatherDayCell: CollectionCell {
    
    func configuredCell(data: ForecastsWeather) -> Self {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        configureIcon(for: data.parts.day.icon)
        dateLabel.text = dateFormatter.string(from: data.date)
        if let prec = data.parts.day.precProb {
            precLabel.text = "\(Int(prec))%"
        }
        conditionLabel.text = data.parts.day.condition
        tempLabel.text = "\(data.parts.night.tempMin) / \(data.parts.day.tempMax)"
        return self
    }
}
