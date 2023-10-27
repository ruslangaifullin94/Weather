//
//  AuthService.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 08.10.2023.
//

import Foundation
import FirebaseAuth

protocol AuthServiceProtocol {
    func checkAuth() -> Bool
}


final class AuthService {
    
}

extension AuthService: AuthServiceProtocol {
    func checkAuth() -> Bool {
        return (Auth.auth().currentUser != nil)
    }
    
    func createUser(email: String, password: String, completion: @escaping (Result<Bool, AuthErrors>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                let errorCode = error as NSError
                switch errorCode.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    completion(.failure(.emailIsUsing))
                case AuthErrorCode.weakPassword.rawValue:
                    completion(.failure(.weakPassword))
                default:
                    completion(.failure(.somethingWentWrong))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<User, AuthErrors>) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                let errorCode = error as NSError
                switch errorCode.code {
                case AuthErrorCode.userNotFound.rawValue:
                    DispatchQueue.main.async {
                        completion(.failure(.userNotFound))
                    }
                case AuthErrorCode.wrongPassword.rawValue:
                    DispatchQueue.main.async {
                        completion(.failure(.invalidPassword))
                    }
                case AuthErrorCode.invalidEmail.rawValue:
                    DispatchQueue.main.async {
                        completion(.failure(.invaildEmail))
                    }
                default:
                    DispatchQueue.main.async {
                        completion(.failure(.somethingWentWrong))
                    }
                }
            }
            
            guard let user = authResult?.user else {
                DispatchQueue.main.async {
                    completion(.failure(.userNotFound))
                }
                return
            }
            
            
        }
    }
}
