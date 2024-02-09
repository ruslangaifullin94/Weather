//
//  HeaderCell.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 16.01.2024.
//

import UIKit

final class HeaderCell: UICollectionReusableView {
    
    private var titleLabel = UILabel()
        .text4
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(LayoutConstants.singleOffset)
            $0.verticalEdges.equalToSuperview().inset(LayoutConstants.singleOffset)
            $0.right.equalToSuperview()
        }
    }
    
}
