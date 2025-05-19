//
//  FeedPresenter.swift
//  ltech
//
//  Created by blacksnow on 5/16/25.
//

final class FeedPresenter: FeedPresenting {
    weak var viewController: FeedView?

    func presentFeedResult(response: FeedModels.Feed.Response) {
        let viewModel = FeedModels.Feed.ViewModel(posts: response.posts)
        viewController?.presentFeedResult(viewModel: viewModel)
    }
}
