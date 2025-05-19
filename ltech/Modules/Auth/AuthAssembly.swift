//
//  AuthAssembly.swift
//  ltech
//
//  Created by blacksnow on 5/15/25.
//

import UIKit

final class AuthAssembly {
    static func build() -> UIViewController {
        let view = AuthViewController()
        let presenter = AuthPresenter()
        let router = AuthRouter()
        let interactor = AuthInteractor(presenter: presenter)

        view.interactor = interactor
        view.router = router
        presenter.viewController = view
        router.viewController = view

        return view
    }
}
