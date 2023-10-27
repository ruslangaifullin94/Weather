//
//  AuthErrors.swift
//  diplom
//
//  Created by Руслан Гайфуллин on 08.10.2023.
//

import Foundation

enum AuthErrors: Error {
    case invaildEmail
    case invalidPassword
    case emailIsUsing
    case weakPassword
    case somethingWentWrong
    case userNotFound
}
