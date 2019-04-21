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
        let cell = UITableViewCell()
        let text = presenter.data[indexPath.row]
        cell.textLabel!.text = text
        if selected.contains(text) {
            addCheckMark(in: cell)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        guard isSelected(cell) else {
            select(cell)
            return
        }
        unselect(cell)
    }
    
    private func isSelected(_ cell: UITableViewCell) -> Bool {
        guard let text = cell.textLabel?.text else { return false }
        return selected.contains(text)
    }
    
    private func select(_ cell: UITableViewCell) {
        addCheckMark(in: cell)
        guard let text = cell.textLabel?.text else { return }
        selected.append(text)
    }
    
    private func unselect(_ cell: UITableViewCell) {
        //TODO:
    }
    
    private func addCheckMark(in cell: UITableViewCell) {
        let imageView = UIImageView(image: UIImage(named: "check_icon") ?? UIImage())
        cell.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(cell).offset(-10)
            make.centerY.equalTo(cell)
        }
    }
    
}


