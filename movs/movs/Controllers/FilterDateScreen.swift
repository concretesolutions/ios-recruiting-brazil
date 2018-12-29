//
//  FilterDateScreen.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 28/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

import UIKit

protocol FilterDateScreenDelegate: class {
    func didSelectDate(_ dateString: String)
}

final class FilterDateScreen: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var datesTableView: UITableView!

    // MARK: - Properties
    private let dates = ["2018", "2017", "2016", "2015", "2014",
                         "2013", "2012", "2011", "2010", "2009",
                         "2008", "2007", "2006", "2005", "2004",
                         "2003", "2002", "2001", "2000"]

    // MARK: - Delegate
    weak var delegate: FilterDateScreenDelegate?
}

// MARK: - UITableViewDataSource
extension FilterDateScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell!.textLabel?.text = dates[indexPath.row]
        return cell!
    }
}

// MARK: - UITableViewDelegate
extension FilterDateScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
		delegate?.didSelectDate(dates[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}
