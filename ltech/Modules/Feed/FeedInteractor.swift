//
//  FeedInteractor.swift
//  ltech
//
//  Created by blacksnow on 5/16/25.
//


final class FeedInteractor: FeedInteracting {
    let presenter: FeedPresenting
    let networkWorker = NetworkWorker()

    init(presenter: FeedPresenting) {
        self.presenter = presenter
    }
    
    func getFeed() {
        networkWorker.request(FeedTarget.posts, responseType: [PostDTO].self) { [weak self] result in
            
            guard let self else { return }
            
            switch result {
                case .success(let data):
                    presenter.presentFeedResult(response: .init(posts: data))
                case .failure(let error):
                    print(error)
                    // TODO: ErrorManager/AlertManager/LoggingSystem
            }
        }
    }
    
}
