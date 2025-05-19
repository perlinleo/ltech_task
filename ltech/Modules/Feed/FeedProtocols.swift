//
//  FeedProtocols.swift
//  ltech
//
//  Created by blacksnow on 5/16/25.
//

// MARK: - View
protocol FeedView: AnyObject {
    func presentFeedResult(viewModel: FeedModels.Feed.ViewModel)
}

// MARK: - Interactor
protocol FeedInteracting {
    func getFeed()
}

// MARK: - Presenter
protocol FeedPresenting {
    func presentFeedResult(response: FeedModels.Feed.Response)
}

// MARK: - Router
protocol FeedRouting {
    func routeToPost(post: PostDTO)
}
