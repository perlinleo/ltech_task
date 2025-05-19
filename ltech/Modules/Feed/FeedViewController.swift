//
//  FeedViewController.swift
//  ltech
//
//  Created by blacksnow on 5/16/25.
//

import UIKit

final class FeedViewController: UIViewController, FeedView {
    // MARK: Public Properties

    var interactor: FeedInteracting?
    var router: FeedRouting?

    // MARK: Private Properties

    private var posts: [PostDTO] = []

    // MARK: Visual Components

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.reuseIdentifier)
        tableView.refreshControl = refreshControl

        return tableView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        refreshControl.beginRefreshing()

        return refreshControl
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true

        return indicator
    }()

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNavigationBar()

        interactor?.getFeed()
        activityIndicator.startAnimating()
    }

    // MARK: - SetupUI

    private func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(tableView)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    private func configureNavigationBar() {
        title = "Лента новостей"

        navigationItem.hidesBackButton = true
        let icon = UIImage(systemName: "arrow.clockwise")
        let updateButton = UIBarButtonItem(
            image: icon,
            style: .plain,
            target: self,
            action: #selector(updateTapped)
        )
        navigationItem.rightBarButtonItem = updateButton
    }

    // MARK: - FeedView

    func presentFeedResult(viewModel: FeedModels.Feed.ViewModel) {
        posts = viewModel.posts
        tableView.reloadData()
        refreshControl.endRefreshing()
        activityIndicator.stopAnimating()
    }

    // MARK: - Private Methods

    @objc private func updateTapped() {
        interactor?.getFeed()
    }

    @objc private func didPullToRefresh() {
        interactor?.getFeed()
    }
}

// MARK: - UITableViewDataSource

extension FeedViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FeedTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? FeedTableViewCell
        else {
            return UITableViewCell()
        }
        let post = posts[indexPath.row]

        cell.configure(image: post.image, title: post.title, description: post.text, date: post.date)

        return cell
    }
}

// MARK: - UITableViewDelegate

extension FeedViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToPost(post: posts[indexPath.row])
    }
}
