//
//  FavoritesView.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 12/01/20.
//  Copyright © 2020 Marcos Santos. All rights reserved.
//

import UIKit

class FavoritesView: UIView, ViewCode {

    lazy var loadingView = LoadingView()

    lazy var emptyView = EmptyView()

    lazy var tableView = UITableView()
        .set(\.backgroundColor, to: .clear)
        .set(\.separatorStyle, to: .none)

    required override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setupSubviews() {
        addSubview(tableView)
        addSubview(loadingView)
        addSubview(emptyView)
    }

    func setupLayout() {
        tableView.fillToSuperview()
        loadingView.fillToSuperview()
        emptyView.fillToSuperview()
    }

    // MARK: View updates

    func setLoadingLayout() {
        loadingView.isHidden = false
        loadingView.start()

        emptyView.isHidden = true
        tableView.isHidden = true
    }

    func setEmptyLayout() {
        loadingView.isHidden = true
        loadingView.stop()

        emptyView.isHidden = false
        tableView.isHidden = true
    }

    func setShowLayout() {
        loadingView.isHidden = true
        loadingView.stop()

        emptyView.isHidden = true
        tableView.isHidden = false
    }
}
