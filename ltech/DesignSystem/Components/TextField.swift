//
//  TextField.swift
//  ltech
//
//  Created by blacksnow on 5/15/25.
//

import InputMask
import UIKit

final class TextField: UIView {
    // MARK: Public Properties

    enum Mode {
        case normal
        case password
        case phoneNumber
    }

    var onTextChange: ((String) -> Void)?

    var text: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    override var accessibilityIdentifier: String? {
        get { textField.accessibilityIdentifier }
        set { textField.accessibilityIdentifier = newValue }
    }

    var error: Error? {
        didSet {
            updateErrorState()
        }
    }

    var phoneMask: String? {
        didSet {
            let inputListener = MaskedTextInputListener(
                primaryFormat: PhoneMaskFormatter.convertMask(phoneMask)
            )
            inputListener.onMaskedTextChangedCallback = { [weak self] _, _, _, _ in
                guard let self, let text else { return }
                onTextChange?(text)
            }
            formatter = inputListener
            textField.delegate = inputListener
        }
    }

    var isPhoneValid: Bool {
        guard let formatter = formatter as? MaskedTextInputListener else { return true }
        return formatter.acceptableTextLength == text?.count
    }

    // MARK: Private Properties

    private var formatter: UITextFieldDelegate?
    private let isSecure: Bool = false
    private let placeholder: String
    private let title: String
    private let mode: Mode

    // MARK: Visual Components

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontBook.bodySemibold

        return label
    }()

    private lazy var textField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.font = FontBook.body
        textField.layer.cornerRadius = Sizes.Corners.default
        textField.clipsToBounds = true
        textField.layer.borderWidth = Sizes.Borders.defaultWidth
        textField.layer.borderColor = Color.gray.cgColor
        textField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)

        return textField
    }()

    private lazy var toggleVisbilityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.addTarget(self, action: #selector(toggleVisibilityAction), for: .touchUpInside)
        button.tintColor = .gray
        button.isHidden = true

        return button
    }()

    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(clearAction), for: .touchUpInside)
        button.tintColor = .gray
        button.isHidden = true

        return button
    }()

    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontBook.footnote
        label.textColor = Color.red
        label.numberOfLines = .zero
        label.isHidden = true
        return label
    }()

    // MARK: - Initializers

    init(placeholder: String, title: String, mode: Mode = .normal) {
        self.mode = mode
        self.placeholder = placeholder
        self.title = title
        super.init(frame: .zero)
        setupUI()
        configureMode()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: SetupUI

    private func setupUI() {
        [titleLabel, textField, errorLabel, toggleVisbilityButton, clearButton].forEach(addSubview)

        if mode == .password {
            toggleVisbilityButton.isHidden = false
        } else {
            clearButton.isHidden = false
        }

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),

            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Sizes.Spacing.x2),
            textField.heightAnchor.constraint(equalToConstant: Constants.height),

            errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Sizes.Spacing.x1),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            toggleVisbilityButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -Sizes.Spacing.x1),
            toggleVisbilityButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),

            clearButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -Sizes.Spacing.x1),
            clearButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
        ])
    }

    // MARK: - Private Methods

    private func configureMode() {
        switch mode {
        case .normal:
            break
        case .password:
            textField.isSecureTextEntry = true
        case .phoneNumber:
            textField.keyboardType = .numberPad
        }
    }

    private func updateErrorState() {
        if let error {
            textField.layer.borderColor = Color.red.cgColor
            errorLabel.text = error.localizedDescription
            errorLabel.isHidden = false
        } else {
            textField.layer.borderColor = Color.gray.cgColor
            errorLabel.text = nil
            errorLabel.isHidden = true
        }
    }

    @objc private func toggleVisibilityAction() {
        toggleVisbilityButton.isSelected.toggle()
        textField.isSecureTextEntry.toggle()
    }

    @objc private func clearAction() {
        textField.text = ""
    }

    @objc private func textDidChanged() {
        onTextChange?(text ?? "")
    }
}

extension TextField {
    private enum Constants {
        static let height: CGFloat = 44
    }
}
