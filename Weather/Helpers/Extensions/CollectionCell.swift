//
//  CollectionCell.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 28.12.2023.
//

import Foundation

protocol CollectionCell {
    associatedtype Model: Hashable
    
    func configuredCell(data: Model) -> Self
}
