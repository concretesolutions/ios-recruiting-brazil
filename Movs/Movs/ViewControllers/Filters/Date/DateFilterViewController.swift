//
//  DateFilterViewController.swift
//  Movs
//
//  Created by Dielson Sales on 08/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class DateFilterViewController: UITableViewController {

    enum Constants {
        static let cellIdentifier = "DateCell"
    }

    var years = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Date"
        populateYears()
        tableView.register(DateFilterCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return years.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? DateFilterCell {
            let year = years[indexPath.row]
            cell.year = year
            cell.textLabel?.text = "\(year)"
            return cell
        }
        fatalError("Cell not configured")
    }

    // MARK: - Populate years

    private func populateYears() {
        let components = Calendar.current.dateComponents([.year], from: Date())
        guard let currentYear = components.year else {
            return
        }
        for year in (1950...currentYear) {
            self.years.append(year)
        }
        self.years = self.years.reversed()
    }
}
