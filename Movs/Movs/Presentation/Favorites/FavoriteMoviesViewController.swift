//
//  FavoriteMoviesViewController.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import os
import SnapKit
import UIKit

class FavoriteMoviesViewController: UIViewController {

    var tableView = FavoriteMoviesTableView()
    //swiftlint:disable weak_delegate
    var tableViewDelegate: FavoriteMoviesTableViewDelegate?
    var tableViewDataSource: FavoriteMoviesTableViewDataSource?

    lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var viewModel: FavoriteMoviesViewModelable

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        os_log(.fault, log: .general, "init(coder:) has not been implemented")
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        self.viewModel = DependencyResolver.shared.resolve(FavoriteMoviesViewModelable.self)
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.presentationState.value = .withoutFilter
    }

    override func viewWillAppear(_ animated: Bool) {
        registerObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterObservers()
    }

    @objc
    func pushFilterOptions() {
        let favoritedMovies = viewModel.favoritedMovies.value
        let filterViewController = FilterOptionsViewController(movies: favoritedMovies, delegate: viewModel)
        filterViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(filterViewController, animated: true)
    }

    @objc
    func removeFilter() {
        viewModel.presentationState.value = .withoutFilter
    }

}

extension FavoriteMoviesViewController: CodeView {

    func buildViewHierarchy() {
        view.addSubview(button)
        view.addSubview(tableView)
    }

    func setupConstraints() {

        tableView.snp.removeConstraints()
        button.snp.removeConstraints()

        if viewModel.presentationState.value == .withoutFilter {

            tableView.snp.makeConstraints { make in
                make.height.equalToSuperview()
                make.bottom.equalToSuperview()
                make.trailing.equalToSuperview()
                make.leading.equalToSuperview()
            }

            button.snp.makeConstraints { make in
                make.bottom.equalTo(tableView.snp.top)
                make.trailing.equalToSuperview()
                make.leading.equalToSuperview()
                make.height.equalTo(0)
            }
        } else {

            tableView.snp.makeConstraints { make in
                make.height.equalToSuperview().multipliedBy(0.8)
                make.bottom.equalToSuperview()
                make.trailing.equalToSuperview()
                make.leading.equalToSuperview()
            }

            button.snp.makeConstraints { make in
                make.bottom.equalTo(tableView.snp.top)
                make.trailing.equalToSuperview()
                make.leading.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(0.1)
            }
        }

    }

    func setupAdditionalConfiguration() {

        button.setTitle("remove.filter".localized, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.setTitleColor(Design.Colors.darkYellow, for: .normal)
        button.backgroundColor = Design.Colors.darkBlue
        button.addTarget(self, action: #selector(removeFilter), for: .touchUpInside)

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: self, action: #selector(pushFilterOptions))
    }

}

extension FavoriteMoviesViewController: UnfavoriteMovieDelegate {

    func deleteRowAt(indexPath: IndexPath) {
        let presentationState = viewModel.presentationState.value
        let movies = presentationState == .withFilter ? self.viewModel.filteredMovies.value : self.viewModel.favoritedMovies.value
        let movie = movies[indexPath.row]
        if viewModel.delete(movie: movie) {
            tableViewDataSource?.favoritedMovies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            viewModel.reloadData()
        }
    }
}

extension FavoriteMoviesViewController: Registrable {

    func registerAdditionalObservers() {
        viewModel.initialize()
        viewModel.reloadUI.bind { _ in
            self.setupView()
        }
        viewModel.favoritedMovies.bind { favoritedMovies in
            guard self.viewModel.presentationState.value == .withoutFilter else {
                return
            }
            self.setupTableView(with: favoritedMovies)
        }
        viewModel.filteredMovies.bind { filteredMovies in
            guard self.viewModel.presentationState.value == .withFilter else {
                return
            }
            self.setupTableView(with: filteredMovies)
            if !filteredMovies.isEmpty {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }

    func setupTableView(with movies: [Movie]) {
        tableViewDelegate = FavoriteMoviesTableViewDelegate(favoritedMovies: movies, delegate: self)
        self.tableView.delegate = tableViewDelegate
        tableViewDataSource = FavoriteMoviesTableViewDataSource(favoritedMovies: movies, tableView: self.tableView)
        self.tableView.dataSource = tableViewDataSource
        self.tableView.reloadData()
    }
}
