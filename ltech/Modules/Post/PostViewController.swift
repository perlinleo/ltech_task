//
//  PostViewController.swift
//  ltech
//
//  Created by blacksnow on 5/18/25.
//

import UIKit
import Kingfisher

final class PostViewController: UIViewController, PostView {
    // MARK: Public Properties
    var interactor: PostInteracting?
    var router: PostRouting?
    
    // MARK: Visual Components
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = FontBook.footnote
        label.textColor = Color.gray
        
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontBook.title
        
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = FontBook.body
        
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var imageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleToFill
        
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, titleLabel, imageView, textLabel])
        stackView.axis = .vertical
        stackView.spacing = Sizes.Spacing.x2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
        
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor?.setupInitialState()
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Sizes.Spacing.x2),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Sizes.Spacing.x2),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Sizes.Spacing.x2),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Sizes.Spacing.x2),

            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -Sizes.Spacing.x4)
        ])
    }
    
    // MARK: - PostView
    func displayPostResult(viewModel: PostModels.Post.ViewModel) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ru_RU")

        dateLabel.text = formatter.string(from: viewModel.post.date)
        titleLabel.text = viewModel.post.title
        textLabel.text = viewModel.post.text

        if let imageURL = URL(string: "http://dev-exam.l-tech.ru" + viewModel.post.image) {
            imageView.kf.setImage(with: imageURL)
        }
    }
}
