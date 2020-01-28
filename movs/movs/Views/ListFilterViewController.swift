//
//  ListFilterViewController.swift
//  movs
//
//  Created by Isaac Douglas on 27/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

class ListFilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var list = [String]()
    var choiseHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setTableView()
    }

}

extension ListFilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = self.list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.choiseHandler?(self.list[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}

extension ListFilterViewController {
    
    internal func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.addFooterView()
        self.tableView.register(cell: UITableViewCell.self)
    
    }
}
