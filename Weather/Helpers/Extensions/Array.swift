//
//  Array.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 27.12.2023.
//

import Foundation

extension Array {
    var isNotEmpty: Bool { !isEmpty }
}

extension Array {
    subscript(safeIndex index: Int) -> Element? {
        get {
            guard index < count && index >= 0 else { return nil }
            return self[index]
        }
        
        set {
            guard let newValue else { return }
            self[index] = newValue
        }
    }
}
