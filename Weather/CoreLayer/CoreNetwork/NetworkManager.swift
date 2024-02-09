//
//  NetworkManager.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 25.12.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func getRequest(enterPoint: EnterPoint) async throws -> Data
}

final class CoreNetworkManager { }

extension CoreNetworkManager: NetworkManagerProtocol {
    
    func getRequest(enterPoint: EnterPoint) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: enterPoint.urlRequest)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.noInternet
        }
        print("http status code: \(response.statusCode)")
        return data
        
    }
}
