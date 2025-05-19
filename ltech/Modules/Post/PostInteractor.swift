//
//  PostInteractor.swift
//  ltech
//
//  Created by blacksnow on 5/18/25.
//

final class PostInteractor: PostInteracting {
    func setupInitialState() {
        presenter.presentPostResult(response: .init(post: post))
    }

    let presenter: PostPresenting
    let networkWorker = NetworkWorker()
    let post: PostDTO

    init(presenter: PostPresenting, post: PostDTO) {
        self.presenter = presenter
        self.post = post
    }
}
