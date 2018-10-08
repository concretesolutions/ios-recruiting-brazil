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

    private var years = [Int]()
    private let settingsDataSource: SettingsDataSource = SettingsDataSourceImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Date"
        populateYears()
        tableView.register(DateFilterCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let selectedYear = settingsDataSource.getYearFilter(),
            let selectedYearIndex = years.firstIndex(where: { $0 == selectedYear }) {
            let indexPath = IndexPath(row: selectedYearIndex, section: 0)
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
        }
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedYear = years[indexPath.row]
        settingsDataSource.setYearFilter(selectedYear)
        NotificationCenter.default.post(name: NSNotification.Name.movie, object: nil)
    }

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
