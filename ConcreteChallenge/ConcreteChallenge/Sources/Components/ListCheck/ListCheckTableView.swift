//
//  ListCheckTableView.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class ListCheckTableView: UIView {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.register(ListCheckItemTableViewCell.self)
        tableView.rowHeight = 48

        let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
        tableView.tableFooterView = tableFooterView

        return tableView
    }()

    // MARK: - Private constants

    private let dataSource: UITableViewDataSource & DataSource = {
        TableViewDataSource<ListCheckItemViewModel, ListCheckItemTableViewCell> { viewModel, cell in
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

    func setupDataSource(items: [ListCheckItemViewModel]) {
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
