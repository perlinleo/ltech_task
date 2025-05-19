//
//  AuthTarget.swift
//  ltech
//
//  Created by blacksnow on 5/16/25.
//

import Foundation
import Alamofire

enum AuthTarget {
    case login(phone: String, password: String)
}

extension AuthTarget: NetworkTarget {
    var baseURL: URL { URL(string: "http://dev-exam.l-tech.ru/api/v1")! }
    
    var path: String {
        switch self {
            case .login: return "/auth"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .login: return .post
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .login(phone, password):
            return [
                "phone": phone,
                "password": password
            ]
        }
    }
    
    var headers: HTTPHeaders? {
        [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
    }
}
