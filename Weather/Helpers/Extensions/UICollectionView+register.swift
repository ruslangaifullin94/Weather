//
//  UICollectionView+register.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 27.12.2023.
//

import UIKit

extension UICollectionView {
    func registerHeader<T: UICollectionReusableView>(_ type: T.Type) {
        register(
            T.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: T.self))
    }
    
    func registerFooter<T: UICollectionReusableView>(_ type: T.Type) {
        register(
            T.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueHeader<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        guard let header = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: T.self),
            for: indexPath
        ) as? T else {
            fatalError("Couldn't find UICollectionReusableView for \(String(describing: T.self))")
        }
        
        return header
    }
    
    func dequeueFooter<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        guard let footer = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: String(describing: T.self),
            for: indexPath
        ) as? T else {
            fatalError("Couldn't find UICollectionReusableView for \(String(describing: T.self))")
        }
        
        return footer
    }
    
    func register<T: UICollectionViewCell & CollectionCell>(_ type: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueCell<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: String(describing: T.self),
            for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionVeiwCell for \(String(describing: T.self))")
        }
        return cell
    }
}

