//
//  AuthViewController.swift
//  ltech
//
//  Created by blacksnow on 5/15/25.
//

import UIKit

final class AuthViewController: UIViewController, AuthView {
    // MARK: Public Properties

    var interactor: AuthInteracting?
    var router: AuthRouting?

    // MARK: Visual Components

    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход в аккаунт"
        label.textAlignment = .center
        label.font = FontBook.title
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var usernameField: TextField = {
        let field = TextField(placeholder: "Телефон", title: "Телефон", mode: .phoneNumber)
        field.onTextChange = { [weak self] _ in
            self?.loginButton.isEnabled = field.isPhoneValid
            print(field.isPhoneValid)
        }
        field.accessibilityIdentifier = "username_field"
        field.translatesAutoresizingMaskIntoConstraints = true
        return field
    }()

    private let passwordField: TextField = {
        let field = TextField(placeholder: "Пароль", title: "Пароль", mode: .password)
        field.translatesAutoresizingMaskIntoConstraints = true
        field.accessibilityIdentifier = "password_field"
        
        return field
    }()

    private lazy var loginButton: Button = {
        let button = Button(title: "Войти", action: { [weak self] in
            guard let self else { return }
            loginButton.isLoading = true
        })
        button.isEnabled = false
        button.accessibilityIdentifier = "login_button"
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        interactor?.setupInitialState()
    }

    // MARK: SetupUI

    private func setupUI() {
        view.backgroundColor = .systemBackground
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [logoView, titleLabel, usernameField, passwordField, loginButton])
        stack.axis = .vertical
        stack.spacing = Sizes.Spacing.x2
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Sizes.Spacing.x3),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizes.Spacing.x3),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Sizes.Spacing.x3),
        ])
    }

    // MARK: - AuthView

    func displayPrefillKeychainResult(viewModel: AuthModels.PrefillCredentials.ViewModel) {
        usernameField.text = viewModel.phone
        passwordField.text = viewModel.password
        usernameField.phoneMask = viewModel.phoneMask
        loginButton.isEnabled = true
    }

    func displayLoginResult(viewModel: AuthModels.Login.ViewModel) {
        loginButton.isLoading = false

        passwordField.error = viewModel.error
        if viewModel.error == nil {
            router?.routeToFeed()
        }
    }

    func displayPhoneMaskResult(viewModel: AuthModels.PhoneMask.ViewModel) {
        usernameField.phoneMask = viewModel.mask
    }

    // MARK: Private Methods

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func loginTapped() {
        let request = AuthModels.Login.Request(
            username: usernameField.text ?? "",
            password: passwordField.text ?? ""
        )
        interactor?.login(request: request)
    }
}
