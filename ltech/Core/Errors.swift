//
//  Errors.swift
//  ltech
//
//  Created by blacksnow on 5/15/25.
//

import UIKit

enum ValidationError: LocalizedError {
    case emptyField
    case invalidPhoneNumber
    case wrongPassword
    
    var errorDescription: String? {
        switch self {
        case .emptyField:
            return "Поле не должно быть пустым"
        case .invalidPhoneNumber:
            return "Некорректный номер телефона"
        case .wrongPassword:
            return "Неверный пароль"
        }
    }
}
