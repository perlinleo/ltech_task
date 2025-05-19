//
//  AuthModels.swift
//  ltech
//
//  Created by blacksnow on 5/15/25.
//

enum AuthModels {
    enum Login {
        struct Request {
            let username: String
            let password: String
        }

        struct Response {
            let success: Bool
        }

        struct ViewModel {
            let error: Error?
        }
    }

    enum PrefillCredentials {
        struct Response {
            let phone: String
            let password: String
            let phoneMask: String
        }

        struct ViewModel {
            let phone: String
            let password: String
            let phoneMask: String
        }
    }

    enum PhoneMask {
        struct Response {
            let mask: String
        }

        struct ViewModel {
            let mask: String
        }
    }
}
