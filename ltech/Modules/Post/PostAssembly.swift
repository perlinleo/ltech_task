//
//  PostAssembly.swift
//  ltech
//
//  Created by blacksnow on 5/18/25.
//

import UIKit

final class PostAssembly {
    static func build(post: PostDTO) -> UIViewController {
        let view = PostViewController()
        let presenter = PostPresenter()
        let router = PostRouter()
        let interactor = PostInteractor(presenter: presenter, post: post)

        view.interactor = interactor
        view.router = router
        presenter.viewController = view
        router.viewController = view

        return view
    }
}
