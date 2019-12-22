//
//  FilterOptionsViewController.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 21/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit

class FilterOptionsViewController: UIViewController {

    // MARK: - Screen

    private lazy var screen = FilterOptionsScreen()

    // MARK: - Life cycle

    override func loadView() {
        self.view = self.screen
        self.screen.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Filters"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(self.applyFilter))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancel))
    }

    // MARK: - Navigation Bar actions

    @objc func applyFilter() {
        // TODO: Apply filter
        self.dismiss(animated: true)
    }

    @objc func cancel() {
        self.dismiss(animated: true)
    }
}

extension FilterOptionsViewController: TableViewScreenDelegate {

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterOptionsCell.reuseIdentifier, for: indexPath) as? FilterOptionsCell else {
            fatalError("Wrong table view cell type")
        }

        switch indexPath.row {
        case 0:
            cell.configure(title: "Dates", detail: "")
        case 1:
            cell.configure(title: "Genres", detail: "")
        default:
            fatalError("Invalid indexPath row")
        }

        return cell
    }

    // MARK: - UITabelViewDelegate

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = //
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
}
