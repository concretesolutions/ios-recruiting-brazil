//
//  FilterOptionsViewController.swift
//  movies
//
//  Created by Jacqueline Alves on 18/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class FilterOptionsViewController: UIViewController {

    var screen: FilterOptionsViewControllerScreen!
    var viewModel: FilterOptionsViewModel!
    
    convenience init(viewModel: FilterOptionsViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func loadView() {
        screen = FilterOptionsViewControllerScreen(frame: UIScreen.main.bounds)
        screen.tableView.dataSource = self
        screen.tableView.delegate = self
        
        self.view = screen
        
        self.title = self.viewModel.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - Data Source
extension FilterOptionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterOptionCell", for: indexPath)
        
        cell.textLabel?.text = self.viewModel.options[indexPath.row]
        
        if self.viewModel.isSelected(at: indexPath.row) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}

// MARK: - Delegate
extension FilterOptionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.toggleSelection(at: indexPath.row)
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
