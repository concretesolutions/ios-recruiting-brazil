//
//  InfoListTableView.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 30/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class InfoListTableView: UIView {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.register(InfoListItemTableViewCell.self)

        let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        tableView.tableFooterView = tableFooterView

        return tableView
    }()

    // MARK: - Private constants

    private let dataSource: UITableViewDataSource & DataSource = {
        TableViewDataSource<InfoListItemViewModel, InfoListItemTableViewCell> { viewModel, cell in
            cell.set(viewModel: viewModel)
        }
    }()

    // MARK: - Initializers

    init(infos: [InfoListItemViewModel]) {
        super.init(frame: .zero)

        setupDataSource(items: infos)
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Functions

    func setupDataSource(items: [InfoListItemViewModel]) {
        dataSource.set(models: items)
        tableView.reloadData()
    }

    // MARK: - Private functions

    private func setupLayout() {
        addSubviewEqual(equalConstraintFor: tableView)

        tableView.backgroundColor = .clear
        backgroundColor = .clear
    }
}
