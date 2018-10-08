//
//  FiltersViewController.swift
//  Movs
//
//  Created by Dielson Sales on 07/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class FiltersViewController: UITableViewController {

    enum Constants {
        static let cellIdentifier = "FiltersCell"
    }

    private let settingsDataSource: SettingsDataSource = SettingsDataSourceImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filter"
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) {
            cell.detailTextLabel?.textColor = GlobalConstants.Colors.goldenOrange
            if indexPath.row == 0 {
                cell.textLabel?.text = "Date"
                if let dateFilter = settingsDataSource.getYearFilter() {
                    cell.detailTextLabel?.text = "\(dateFilter)"
                } else {
                    cell.detailTextLabel?.text = ""
                }
            } else {
                cell.textLabel?.text = "Genre"
                if let genreFilter = settingsDataSource.getGenreFilter() {
                    cell.detailTextLabel?.text = genreFilter
                } else {
                    cell.detailTextLabel?.text = ""
                }
            }
            return cell
        }
        fatalError("Cell not configured")
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let dateFilterViewController = DateFilterViewController()
            self.navigationController?.pushViewController(dateFilterViewController, animated: true)
        } else {
            let genreFilterViewController = GenreFilterViewController()
            self.navigationController?.pushViewController(genreFilterViewController, animated: true)
        }
    }
}
