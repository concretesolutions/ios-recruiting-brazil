//
//  HorizontalInfoListTableView.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class HorizontalInfoListTableView: UIView, UITableViewDelegate {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.register(HorizontalInfoListViewCell.self)
        tableView.rowHeight = 120

        let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        tableView.tableFooterView = tableFooterView

        return tableView
    }()

    // MARK: - Private variables

    private var onItemUnfavoritePress: ((_ index: Int) -> Void)?

    // MARK: - Private constants

    private let dataSource: UITableViewDataSource & DataSource = {
        TableViewDataSource<HorizontalInfoListViewModel, HorizontalInfoListViewCell> { viewModel, cell in
            cell.selectionStyle = .none
            cell.set(viewModel: viewModel)
        }
    }()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)

        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Functions

    func setupDataSource(items: [HorizontalInfoListViewModel]) {
        dataSource.set(models: items)
        tableView.reloadData()
    }

    func bind (onUnfavoritePress handler: @escaping (_ index: Int) -> Void) {
        tableView.delegate = self
        onItemUnfavoritePress = handler
    }

    // MARK: - UITableViewDelegate conforms

    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath)
        ])
    }

    // MARK: - Private functions

    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: Strings.unfavorite.localizable) { [weak self] (action, swipeButtonView, completion) in

            self?.onItemUnfavoritePress?(indexPath.row)

            completion(true)
        }
    }

    private func setupLayout() {
        addSubviewEqual(equalConstraintFor: tableView)

        tableView.backgroundColor = .clear
        backgroundColor = .clear
    }
}
