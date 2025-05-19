//
//  NetworkWorker.swift
//  ltech
//
//  Created by blacksnow on 5/16/25.
//

import Alamofire

final class NetworkWorker {
    func request<T: Decodable>(
        _ target: NetworkTarget,
        responseType: T.Type,
        completion: @escaping (Result<T, AFError>) -> Void
    ) {
        let url = target.baseURL.appendingPathComponent(target.path)

        AF.request(
            url,
            method: target.method,
            parameters: target.parameters,
            encoding: URLEncoding.default,
            headers: target.headers
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
}
