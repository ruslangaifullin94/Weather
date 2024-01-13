//
//  SearchResultCell.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 28.12.2023.
//

import UIKit

final class SearchResultCell: UICollectionViewCell {
    
    private lazy var cityLabel = UILabel()
        .text1
        .with(\.numberOfLines, setTo: 1)
    
    private lazy var descLabel = UILabel()
        .text2
        .with(\.numberOfLines, setTo: 1)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubviews(cityLabel, descLabel)
        
        cityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(LayoutConstants.minimumOffset)
            $0.left.equalToSuperview().inset(LayoutConstants.minimumOffset)
            $0.width.equalToSuperview()
        }
        
        descLabel.snp.makeConstraints {
            $0.top.equalTo(cityLabel.snp.bottom).inset(LayoutConstants.textHalfVerticalOffset)
            $0.left.equalToSuperview().inset(LayoutConstants.minimumOffset)
            $0.width.equalToSuperview()
        }
    }
}

extension SearchResultCell: CollectionCell {
    
    func configuredCell(data: CitySearchModel) -> Self {
        cityLabel.text = data.name
        descLabel.text = data.description
        return self
    }
}
