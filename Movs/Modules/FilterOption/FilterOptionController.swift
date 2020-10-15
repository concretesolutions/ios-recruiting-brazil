//
//  FilterOptionController.swift
//  Movs
//
//  Created by Joao Lucas on 15/10/20.
//

import UIKit

class FilterOptionController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Filter option"
    }
    
    @objc func btnApply() {
        print("Apply")
    }
}

extension FilterOptionController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Year"
            cell.accessoryType = .disclosureIndicator
        case 1:
            cell.textLabel?.text = "Genre"
            cell.accessoryType = .disclosureIndicator
        default:
            fatalError()
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(btnApply), for: .touchUpInside)
        button.heightAnchor(equalTo: 50)
        return button
    }
}
