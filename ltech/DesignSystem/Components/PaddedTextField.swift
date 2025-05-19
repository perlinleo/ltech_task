//
//  PaddedTextField.swift
//  ltech
//
//  Created by blacksnow on 5/15/25.
//

import UIKit

final class PaddedTextField: UITextField {
    var textInsets = UIEdgeInsets(
        top: Sizes.Spacing.x1,
        left: Sizes.Spacing.x2,
        bottom: Sizes.Spacing.x1,
        right: Sizes.Spacing.x2
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        adjustedRect(for: bounds)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        adjustedRect(for: bounds)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        adjustedRect(for: bounds)
    }

    private func adjustedRect(for bounds: CGRect) -> CGRect {
        var insets = textInsets
        insets.right += Sizes.Spacing.x4

        return bounds.inset(by: insets)
    }
}
