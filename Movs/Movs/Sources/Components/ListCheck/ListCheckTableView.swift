//
//  ListCheckTableView.swift
//  Movs
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class ListCheckTableView: UIView, UITableViewDelegate {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.register(ListCheckItemTableViewCell.self)
        tableView.rowHeight = 48
        tableView.delegate = self

        let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
        tableView.tableFooterView = tableFooterView

        return tableView
    }()

    // MARK: - Private variables

    private var onItemPress: ((_ index: Int) -> Void)?

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

    func bind (onItemPress handler: @escaping (_ index: Int) -> Void) {
        onItemPress = handler
    }

    // MARK: - UITableViewDelegate conforms

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        self.onItemPress?(indexPath.row)
    }

    // MARK: - Private functions

    private func setupLayout() {
        addSubviewEqual(equalConstraintFor: tableView)

        tableView.backgroundColor = .clear
        backgroundColor = .clear
    }
}
