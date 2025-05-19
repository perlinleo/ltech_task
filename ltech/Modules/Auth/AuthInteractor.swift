//
//  AuthInteractor.swift
//  ltech
//
//  Created by blacksnow on 5/15/25.
//



final class AuthInteractor: AuthInteracting {
    
    
    // MARK: - Public Properties
    let presenter: AuthPresenting
    var mask: String?
    let networkWorker = NetworkWorker()
    
    // MARK: - Initializers
    init(presenter: AuthPresenting) {
        self.presenter = presenter
    }

    // MARK: - AuthInteracting
    func setupInitialState() {
        prefillCredentials() { hasPrefilledCredentials in
            if !hasPrefilledCredentials {
               getPhoneMasks()
            }
        }
    }
    
    func login(request: AuthModels.Login.Request) {
        let strippedPhoneNumber = request.username.filter(\.isNumber)
        networkWorker.request(AuthTarget.login(phone: strippedPhoneNumber, password: request.password), responseType: LoginResponseDTO.self) { [weak self] result in
            
            guard let self else { return }
            
            switch result {
                case .success(let data):
                    KeychainWorker.save(key: .userPhone, value: request.username)
                    KeychainWorker.save(key: .userPassword, value: request.password)
                    KeychainWorker.save(key: .phoneMask, value: mask)
                    presenter.presentLoginResult(response: .init(success: data.success))
                case .failure:
                    presenter.presentLoginResult(response: .init(success: false))
            }
        }
    }
    
    // MARK: - Private Methods
    private func prefillCredentials(callback: ((Bool) -> Void)) {
        if let password = KeychainWorker.load(key: .userPassword),
           let phone = KeychainWorker.load(key: .userPhone),
           let phoneMask = KeychainWorker.load(key: .phoneMask) {
            presenter.presentPrefillKeychainResult(response: .init(phone: phone, password: password, phoneMask: phoneMask))
            callback(true)
        } else {
            callback(false)
        }
    }
    
    private func getPhoneMasks() {
        networkWorker.request(MasksTarget.phoneMask, responseType: PhoneMaskDTO.self) { [weak self] result in
            guard let self else { return }
            
            switch result {
                case .success(let data):
                    mask = data.phoneMask
                    presenter.presentMaskResult(response: .init(mask: data.phoneMask))
                case .failure(let error):
                    print(error)
            }
        }
    }
}
