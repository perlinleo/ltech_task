//
//  AuthProtocols.swift
//  ltech
//
//  Created by blacksnow on 5/15/25.
//

// MARK: - View
protocol AuthView: AnyObject {
    func displayLoginResult(viewModel: AuthModels.Login.ViewModel)
    func displayPhoneMaskResult(viewModel: AuthModels.PhoneMask.ViewModel)
    func displayPrefillKeychainResult(viewModel: AuthModels.PrefillCredentials.ViewModel)
}

// MARK: - Interactor
protocol AuthInteracting {
    func setupInitialState()
    func login(request: AuthModels.Login.Request)
}

// MARK: - Presenter
protocol AuthPresenting {
    func presentLoginResult(response: AuthModels.Login.Response)
    func presentMaskResult(response: AuthModels.PhoneMask.Response)
    func presentPrefillKeychainResult(response: AuthModels.PrefillCredentials.Response)
}

// MARK: - Router
protocol AuthRouting {
    func routeToFeed()
}
