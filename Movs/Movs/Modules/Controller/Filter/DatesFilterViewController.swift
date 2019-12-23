//
//  DatesFilterViewController.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 22/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit

class DatesFilterViewController: UIViewController {

    // MARK: - Delegate

    weak var delegate: DatesFilterDelegate?

    // MARK: - Screen

    private let screen = FilterScreen()

    // MARK: - Model

    private var dates: [String] = []

    // MARK: - Life cycle

    override func loadView() {
        self.view = self.screen
        self.screen.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Dates"
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(self.clear))
    }

    override func viewWillAppear(_ animated: Bool) {
        self.dates = self.delegate?.dates ?? []
        self.screen.tableView.reloadData()
    }

    // MARK: - Clear

    @objc private func clear() {
        self.delegate?.tempSelectedDates = []
        self.screen.tableView.reloadData()
    }
}

extension DatesFilterViewController: TableViewScreenDelegate {

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.reuseIdentifier, for: indexPath) as? FilterCell else {
            fatalError("Wrong table view cell type")
        }

        guard let delegate = self.delegate else {
            fatalError("No delegate")
        }

        let date = self.dates[indexPath.row]

        cell.configure(title: date)
        cell.accessoryView = delegate.tempSelectedDates.contains(date) ? UIImageView(image: UIImage(systemName: "checkmark")) : nil

        return cell
    }

    // MARK: - UITabelViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = self.delegate else {
            fatalError("No delegate")
        }

        let date = self.dates[indexPath.row]

        if delegate.tempSelectedDates.contains(date) {
            delegate.tempSelectedDates.remove(date)
        } else {
            delegate.tempSelectedDates.insert(date)
        }

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
