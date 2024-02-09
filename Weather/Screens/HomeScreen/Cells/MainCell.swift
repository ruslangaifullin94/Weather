//
//  MainCell.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 27.12.2023.
//

import UIKit

final class MainCell: UICollectionViewCell {
    
    private let dateFormatter = DateFormatter()
        .with {
            $0.dateFormat = "HH:mm, E d MMMM"
        }
    
    private lazy var tempLabel = UILabel()
        .text3
        .with(\.textColor, setTo: .white)
    
    private lazy var conditionLabel = UILabel()
        .text1
        .with(\.textColor, setTo: .white)
    
    private lazy var dateLabel = UILabel()
        .text1
        .withTextColor(.yellow)
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor(named: "mainColor")
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.clipsToBounds = true
        makeRoundCorners(.all, radius: LayoutConstants.smallRadius)
        addSubviews(tempLabel, conditionLabel, dateLabel)
        
        tempLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(58)
            $0.left.equalToSuperview().inset(147)
        }
        
        conditionLabel.snp.makeConstraints {
            $0.top.equalTo(tempLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
    
    }
}

extension MainCell: CollectionCell {
    
    func configuredCell(data: FactWeather) -> Self {
        tempLabel.text = "\(data.temp)"
        conditionLabel.text = data.condition
        dateLabel.text = dateFormatter.string(from: Date())
        return self
    }
}
