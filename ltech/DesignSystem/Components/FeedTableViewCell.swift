//
//  FeedTableViewCell.swift
//  ltech
//
//  Created by blacksnow on 5/16/25.
//

import UIKit
import Kingfisher

final class FeedTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CustomTableViewCell"

    // MARK: - Visual Components
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.widthAnchor.constraint(equalToConstant: Constants.previewImageHeight).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.previewImageHeight).isActive = true
        
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontBook.title
        label.numberOfLines = Constants.titleNumberOfLines
        
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = FontBook.body
        label.textColor = .secondaryLabel
        label.numberOfLines = Constants.descriptionNumberOfLines
        
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = FontBook.footnote
        label.textColor = .tertiaryLabel
        label.textAlignment = .left
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        return label
    }()

    private lazy var textStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, dateLabel])
        stack.axis = .vertical
        stack.spacing = Sizes.Spacing.x0_5
        
        return stack
    }()

    private lazy var mainStack: UIStackView = {
        let horizontalStack = UIStackView(arrangedSubviews: [cellImageView, textStack])
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = Sizes.Spacing.x1_5
        horizontalStack.alignment = .center
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false

        return horizontalStack
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Sizes.Spacing.x1_5),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Sizes.Spacing.x2),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Sizes.Spacing.x2),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Sizes.Spacing.x1_5)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func configure(image: String?, title: String, description: String, date: Date) {
        if let image, let imageURL = URL(string: "http://dev-exam.l-tech.ru"+image) {
            cellImageView.kf.setImage(with: imageURL)
        }
        titleLabel.text = title
        descriptionLabel.text = description
        dateLabel.text = format(date: date)
    }

    private func format(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

extension FeedTableViewCell {
    private enum Constants {
        static let previewImageHeight: CGFloat = 80
        static let titleNumberOfLines = 1
        static let descriptionNumberOfLines = 2
    }
}
