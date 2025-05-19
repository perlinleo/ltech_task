//
//  PostPresenter.swift
//  ltech
//
//  Created by blacksnow on 5/18/25.
//

final class PostPresenter: PostPresenting {
    func presentPostResult(response: PostModels.Post.Response) {
        viewController?.displayPostResult(viewModel: .init(post: response.post))
    }
    
    
    weak var viewController: PostView?
}
