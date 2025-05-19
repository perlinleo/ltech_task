//
//  PostProtocols.swift
//  ltech
//
//  Created by blacksnow on 5/18/25.
//

// MARK: - View

protocol PostView: AnyObject {
    func displayPostResult(viewModel: PostModels.Post.ViewModel)
}

// MARK: - Interactor

protocol PostInteracting {
    func setupInitialState()
}

// MARK: - Presenter

protocol PostPresenting {
    func presentPostResult(response: PostModels.Post.Response)
}

// MARK: - Router

protocol PostRouting {}
