//
//  LayoutBuilderDayController.swift
//  Weather
//
//  Created by Руслан Гайфуллин on 14.01.2024.
//

import UIKit

struct LayoutBuilderDayController {
    func build(section: DayViewController.Section) -> NSCollectionLayoutSection? {
        switch section {
        case .days:
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .absolute(widthDimensionDate),
                heightDimension: .absolute(heightDimensionDate)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(widthDimensionDate),
                heightDimension: .absolute(heightDimensionDate)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: LayoutConstants.singleOffset,
                bottom: LayoutConstants.oneAndHalfOffset,
                trailing: LayoutConstants.singleOffset
            )
            section.interGroupSpacing = LayoutConstants.singleOffset
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            return section
        case .forecasts:
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(heightDimensionDay)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(heightDimensionDay)
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: LayoutConstants.singleOffset,
                bottom: LayoutConstants.oneAndHalfOffset,
                trailing: LayoutConstants.singleOffset
            )
            section.interGroupSpacing = LayoutConstants.singleOffset
            return section
        case .moon:
            let contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: LayoutConstants.singleOffset,
                bottom: LayoutConstants.oneAndHalfOffset,
                trailing: LayoutConstants.singleOffset
            )
            return .singleRowSection(height: .estimated(400))
                .with(\.contentInsets, setTo: contentInsets)
            
        }
    }
}

private let widthDimensionDate = 88.0
private let heightDimensionDate = 36.0

private let widthDimensionDay = 344.0
private let heightDimensionDay = 341.0
