//
//  FavoriteMoviesScreen.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 19/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import SnapKit
import UIKit

final class FavoriteMoviesScreen: UIView {

    // MARK: - Delegate

    weak var delegate: FavoriteMoviesScreenDelegate? {
        didSet {
            self.tableView.delegate = self.delegate
            self.tableView.dataSource = self.delegate
        }
    }

    // MARK: - Subviews

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.register(FavoriteMovieCell.self, forCellReuseIdentifier: FavoriteMovieCell.reusableIdentifier)
        view.delegate = self.delegate
        view.dataSource = self.delegate
        view.backgroundColor = .systemBackground
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        return view
    }()

    private lazy var emptyView: ExceptionView = {
        let view = ExceptionView(imageSystemName: "heart", text: "You don't have any favorite movies yet.")
        return view
    }()

    // MARK: - Initializers

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Empty handlers

    func displayEmptyView() {
        self.tableView.backgroundView = self.emptyView
    }

    func hideEmptyView() {
        self.tableView.backgroundView = nil
    }
}

extension FavoriteMoviesScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.tableView)
    }

    func setupContraints() {
        self.tableView.snp.makeConstraints { maker in
            maker.top.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .systemBackground
    }
}
