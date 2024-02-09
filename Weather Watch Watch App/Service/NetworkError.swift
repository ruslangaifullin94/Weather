//
//  NetworkError.swift
//  Weather Watch Watch App
//
//  Created by Руслан Гайфуллин on 09.02.2024.
//

import Foundation

enum NetworkError: Error {
    case noInternet
    case noData
    case somethingWentWrong
    
    var errorDescription: String {
        switch self {
        case .noInternet:
            return "notInternet"
        case .noData:
            return "notData"
        case .somethingWentWrong:
            return "somethingWentWrong"
        }
    }
}
