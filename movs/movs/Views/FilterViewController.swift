//
//  FilterViewController.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = Localizable.filter
        
        self.setButton()
        self.setTableView()
    }

    @IBAction func buttonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController {
    internal func setButton() {
        self.button.setTitle(Localizable.apply, for: .normal)
        self.button.setTitleColor(.black, for: .normal)
        self.button.backgroundColor = .primary
        self.button.roundedCorners()
        self.button.shadow()
    }
    
    internal func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.addFooterView()
        self.tableView.register(cell: UITableViewCell.self)
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: UITableViewCell.identifier)
        cell.selectionStyle = .none
        cell.textLabel?.text = "Title"
        cell.detailTextLabel?.text = "Detail"
        cell.detailTextLabel?.textColor = .primary
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
}
