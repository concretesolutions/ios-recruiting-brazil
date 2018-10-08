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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) {
            if indexPath.row == 0 {
                cell.textLabel?.text = "Date"
            } else {
                cell.textLabel?.text = "Genre"
            }
            return cell
        }
        fatalError("Cell not configured")
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select filter cell")
    }
}
