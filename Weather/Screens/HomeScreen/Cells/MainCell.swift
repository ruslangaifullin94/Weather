//
//  MainCell.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 27.12.2023.
//

import UIKit

final class MainCell: UICollectionViewCell {
    
    private lazy var tempLabel = UILabel()
        .text3
        .with(\.textColor, setTo: .white)
    
    private lazy var conditionLabel = UILabel()
        .text1
        .with(\.textColor, setTo: .white)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor(named: "mainColor")
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        makeRoundCorners(.all, radius: LayoutConstants.smallRadius)
        addSubviews(tempLabel, conditionLabel)
        
        tempLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(58)
            $0.left.equalToSuperview().inset(147)
        }
        
        conditionLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
    }
}

extension MainCell: CollectionCell {
    
    func configuredCell(data: FactWeather) -> Self {
        tempLabel.text = "\(data.temp)"
        conditionLabel.text = data.condition
        return self
    }
}
