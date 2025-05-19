//
//  FeedAssembly.swift
//  ltech
//
//  Created by blacksnow on 5/16/25.
//

import UIKit

enum FeedAssembly {
    static func build() -> UIViewController {
        let view = FeedViewController()
        let presenter = FeedPresenter()
        let router = FeedRouter()
        let interactor = FeedInteractor(presenter: presenter)

        view.interactor = interactor
        view.router = router
        presenter.viewController = view
        router.viewController = view

        return view
    }
}
