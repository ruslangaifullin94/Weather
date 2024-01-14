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
    
    private var conditionLabel = UILabel()
        .navTitle
    
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
        addSubviews(dayLabel, tempStackView, conditionLabel)
        
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
        return self
    }
}
