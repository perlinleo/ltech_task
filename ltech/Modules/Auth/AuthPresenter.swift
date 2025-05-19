//
//  AuthPresenter.swift
//  ltech
//
//  Created by blacksnow on 5/15/25.
//

final class AuthPresenter: AuthPresenting {
    weak var viewController: AuthView?

    func presentPrefillKeychainResult(response: AuthModels.PrefillCredentials.Response) {
        let viewModel = AuthModels.PrefillCredentials.ViewModel(phone: response.phone, password: response.password, phoneMask: response.phoneMask)
        viewController?.displayPrefillKeychainResult(viewModel: viewModel)
    }

    func presentMaskResult(response: AuthModels.PhoneMask.Response) {
        let viewModel = AuthModels.PhoneMask.ViewModel(mask: response.mask)
        viewController?.displayPhoneMaskResult(viewModel: viewModel)
    }

    func presentLoginResult(response: AuthModels.Login.Response) {
        let error = response.success ? nil : ValidationError.wrongPassword
        let viewModel = AuthModels.Login.ViewModel(error: error)
        viewController?.displayLoginResult(viewModel: viewModel)
    }
}
