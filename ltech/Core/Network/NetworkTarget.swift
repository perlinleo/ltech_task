//
//  NetworkTarget.swift
//  ltech
//
//  Created by blacksnow on 5/16/25.
//

import Foundation
import Alamofire

protocol NetworkTarget {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
}
