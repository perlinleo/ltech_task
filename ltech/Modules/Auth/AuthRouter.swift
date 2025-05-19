//
//  AuthRouter.swift
//  ltech
//
//  Created by blacksnow on 5/15/25.
//

import UIKit

final class AuthRouter: AuthRouting {
    // MARK: - Public Properties

    weak var viewController: UIViewController?

    // MARK: - AuthRouting

    func routeToFeed() {
        let feedViewController = FeedAssembly.build()
        viewController?.navigationController?.pushViewController(feedViewController, animated: true)
    }
}
