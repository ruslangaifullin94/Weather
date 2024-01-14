//
//  WeatherTimeCell.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 27.12.2023.
//

import UIKit

final class WeatherTimeCell: UICollectionViewCell {
    
    private var loadImageTask: Task<Void, Never>?
    
    private lazy var timeLabel = UILabel()
        .text2
    
    private lazy var tempLabel = UILabel()
        .text2
    
    private lazy var iconView = UIImageView()
        
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        contentView.makeRoundCorners(.all, radius: 20)
        contentView.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.layer.masksToBounds = true
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        makeRoundCorners(.all, radius: 20)
        addSubviews(tempLabel, timeLabel, iconView)
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.centerX.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(5)
            $0.centerX.equalToSuperview()
        }
        
        iconView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(20)
        }
    }
    
    private func configureIcon(for url: URL) {
        loadImageTask?.cancel()
        
        loadImageTask = Task { [weak self] in
            guard let self else { return }
            self.iconView.image = nil
            do {
                try await self.iconView.setImage(by: url)
                self.iconView.contentMode = .scaleAspectFit
            } catch {
                self.iconView.image = UIImage(systemName: "exclamationmark.icloud")
                self.iconView.contentMode = .center
            }            
        }
    }
}

extension WeatherTimeCell: CollectionCell {
    
    func configuredCell(data: WeatherHour) -> Self {
        timeLabel.text = "\(data.hour)"
        tempLabel.text = "\(data.temp)"
        configureIcon(for: data.icon)
        return self
    }
}
