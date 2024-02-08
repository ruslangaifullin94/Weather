//
//  GraphCell.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 21.01.2024.
//

import UIKit
import SwiftUI
import Charts

final class GraphCell: UICollectionViewCell {
    
    private lazy var graphView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupChart(data: [WeatherHour]) -> UIView {
        let graphView = GraphView(data: data)
        let view = HostingView(rootView: graphView)
        return view
    }
    
    private func setupView() {
        addSubview(graphView)
        graphView.snp.makeConstraints {
            $0.edges.equalToSuperview().offset(LayoutConstants.minimumOffset)
        }
    }
}

extension GraphCell: CollectionCell {
    
    func configuredCell(data: [WeatherHour]) -> Self {
        graphView = setupChart(data: data)
        setupView()
        return self
    }
    
}
