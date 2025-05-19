//
//  FeedModels.swift
//  ltech
//
//  Created by blacksnow on 5/16/25.
//

enum FeedModels {
    enum Feed {
        struct Response {
            let posts: [PostDTO]
        }

        struct ViewModel {
            let posts: [PostDTO]
        }
    }
}
