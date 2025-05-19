//
//  MasksTarget.swift
//  ltech
//
//  Created by blacksnow on 5/16/25.
//

import Alamofire
import Foundation

enum MasksTarget {
    case phoneMask
}

extension MasksTarget: NetworkTarget {
    var baseURL: URL { URL(string: "http://dev-exam.l-tech.ru/api/v1")! }
    
    var path: String {
        switch self {
            case .phoneMask: return "/phone_masks"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .phoneMask: return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
            case .phoneMask:
                return [:]
        }
    }
    
    var headers: HTTPHeaders? {
        [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
    }
}
