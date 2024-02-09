//
//  LayoutBuilderHomeViewController.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 27.12.2023.
//

import UIKit

struct LayoutBuilderHomeViewController {
    func build(for section: HomeViewController.Sections) -> NSCollectionLayoutSection? {
        switch section {
        case .main:
            let contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: LayoutConstants.singleOffset,
                bottom: LayoutConstants.oneAndHalfOffset,
                trailing: LayoutConstants.singleOffset
            )
            return .singleRowSection(height: .estimated(heightDimensionMain))
                .with(\.contentInsets, setTo: contentInsets)
            
        case .timing:
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .absolute(widthDimensionTime),
                heightDimension: .absolute(heightDimensionTime)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(widthDimensionTime),
                heightDimension: .absolute(heightDimensionTime)
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
        case .days:
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
                bottom: 0,
                trailing: LayoutConstants.singleOffset
            )
            section.interGroupSpacing = LayoutConstants.minimumOffset
            return section
        }
    }
}

private let heightDimensionMain = 212.0
private let widthDimensionTime = 42.0
private let heightDimensionTime = 84.0
private let heightDimensionDay = 56.0


