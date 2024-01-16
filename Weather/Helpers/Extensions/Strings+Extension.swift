//
//  Strings+Extension.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 28.10.2023.
//

import Foundation
extension String {
    var localized: String {
        NSLocalizedString(self, comment: self)
    }
}
