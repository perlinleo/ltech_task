//
//  FeedRouter.swift
//  ltech
//
//  Created by blacksnow on 5/16/25.
//

import UIKit

final class FeedRouter: FeedRouting {
    weak var viewController: UIViewController?
    
    func routeToPost(post: PostDTO) {
        let postViewController = PostAssembly.build(post: post)
        viewController?.navigationController?.pushViewController(postViewController, animated: true)
    }
}
