//
//  NetworkErrors.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 25.12.2023.
//

import Foundation

enum NetworkError: Error {
    case noInternet
    case noData
    case somethingWentWrong
    
    var errorDescription: String {
        switch self {
        case .noInternet:
            return "notInternet".localized
        case .noData:
            return "notData".localized
        case .somethingWentWrong:
            return "somethingWentWrong".localized
        }
    }
}
