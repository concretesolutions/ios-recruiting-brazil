//
//  FilterViewController.swift
//  movs
//
//  Created by Lorien Moisyn on 20/04/19.
//  Copyright © 2019 Auspex. All rights reserved.
//

import UIKit
import SnapKit

class BaseFilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: FilterPresenter!
    var selected: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        presenter = FilterPresenter(vc: self)
    }
    
    func updateLayout() {
        tableView.reloadData()
    }

}

extension BaseFilterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? FilterTableViewCell else { return UITableViewCell() }
        let text = presenter.data[indexPath.row]
        cell.textLabel!.text = text
        cell.checkedImageView.isHidden = !selected.contains(text)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FilterTableViewCell else { return }
        guard isSelected(cell) else {
            select(cell)
            return
        }
        deselect(cell)
    }
    
    private func isSelected(_ cell: UITableViewCell) -> Bool {
        guard let text = cell.textLabel?.text else { return false }
        return selected.contains(text)
    }
    
    private func select(_ cell: FilterTableViewCell) {
        cell.checkedImageView.isHidden = false
        guard let text = cell.textLabel?.text else { return }
        selected.append(text)
    }
    
    private func deselect(_ cell: FilterTableViewCell) {
        cell.checkedImageView.isHidden = true
        guard let text = cell.textLabel?.text else { return }
        selected.removeAll { $0 == text }
    }
    
}


