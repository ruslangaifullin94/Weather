//
//  NSCollectionLayoutSection+Extension.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 28.12.2023.
//

import UIKit

extension NSCollectionLayoutSection {
    static func singleRowSection(height: NSCollectionLayoutDimension) -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: height
        )
        
        return NSCollectionLayoutSection(
            group: NSCollectionLayoutGroup.vertical(
                layoutSize: size,
                subitems: [NSCollectionLayoutItem(layoutSize: size)]
            )
        )
    }
}
