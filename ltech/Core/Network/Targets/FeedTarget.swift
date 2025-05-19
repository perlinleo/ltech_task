//
//  FeedTarget.swift
//  ltech
//
//  Created by blacksnow on 5/16/25.
//

import Alamofire
import Foundation

enum FeedTarget {
    case posts
}

extension FeedTarget: NetworkTarget {
    var baseURL: URL { URL(string: "http://dev-exam.l-tech.ru/api/v1")! }
    
    var path: String {
        switch self {
            case .posts: return "/posts"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .posts: return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
            case .posts:
                return [:]
        }
    }
    
    var headers: HTTPHeaders? {
        [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
    }
}
