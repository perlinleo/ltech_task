//
//  Button.swift
//  ltech
//
//  Created by blacksnow on 5/15/25.
//

import UIKit

final class Button: UIButton {
    private var action: (() -> Void)?
    private let spinner = UIActivityIndicatorView(style: .medium)

    var isLoading: Bool = false {
        didSet {
            updateLoadingState()
        }
    }

    init(title: String, action: @escaping () -> Void) {
        super.init(frame: .zero)
        self.action = action
        setup(title: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.textAlignment = .center
        spinner.color = .white

        layer.cornerRadius = 16
        clipsToBounds = true

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        addSubview(spinner)

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        updateBackground()
        updateLoadingState()

        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }

    override var isEnabled: Bool {
        didSet {
            updateBackground()
        }
    }

    private func updateBackground() {
        backgroundColor = isEnabled
            ? Color.blue
            : Color.blue.withAlphaComponent(0.7)
    }

    private func updateLoadingState() {
        if isLoading {
            spinner.startAnimating()
            setTitleColor(.clear, for: .normal)
            isUserInteractionEnabled = false
        } else {
            spinner.stopAnimating()
            setTitleColor(.white, for: .normal)
            isUserInteractionEnabled = true
        }
    }

    @objc private func didTap() {
        guard isEnabled && !isLoading else { return }
        action?()
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 54)
    }

    // MARK: - Touch Animation

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard !isLoading else { return false }
        animateTransform(scale: 0.97)
        return super.beginTracking(touch, with: event)
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        animateTransform(scale: 1.0)
        super.endTracking(touch, with: event)
    }

    override func cancelTracking(with event: UIEvent?) {
        animateTransform(scale: 1.0)
        super.cancelTracking(with: event)
    }

    private func animateTransform(scale: CGFloat) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseInOut],
                       animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: nil)
    }
}


