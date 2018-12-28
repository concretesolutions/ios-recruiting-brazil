//
//  FilterListScreen.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 27/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

import UIKit

final class FilterListScreen: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var filtersTableView: UITableView!

    // MARK: - Properties
    private let filters = ["Date", "Genders"]
}

// MARK: - Lifecycle
extension FilterListScreen {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Private
extension FilterListScreen {
    private func setupUI() {
		filtersTableView.tableFooterView = UIView()
        filtersTableView.register(FilterListCell.self)
    }
}

// MARK: - UITableViewDataSource
extension FilterListScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FilterListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.textLabel!.text = filters[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FilterListScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
		// TO DO
    }
}
