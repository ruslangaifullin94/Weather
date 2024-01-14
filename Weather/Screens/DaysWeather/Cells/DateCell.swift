//
//  DateCell.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 14.01.2024.
//

import UIKit

final class DateCell: UICollectionViewCell {
    private var dateLabel = UILabel()
        .navTitle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        makeRoundCorners(.all, radius: LayoutConstants.smallRadius)
        addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension DateCell: CollectionCell {
    func configuredCell(data: ForecastsWeather) -> Self {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateLabel.text = dateFormatter.string(from: data.date)
        return self
    }
}
