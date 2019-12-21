//
//  FilterViewController.swift
//  movies
//
//  Created by Jacqueline Alves on 10/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit
import Combine

class FilterViewController: UIViewController {
    var screen: FilterViewControllerScreen!
    var viewModel: FilterViewViewModel!
    
    convenience init(viewModel: FilterViewViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func loadView() {
        screen = FilterViewControllerScreen(frame: UIScreen.main.bounds)
        screen.tableView.dataSource = self
        screen.tableView.delegate = self
        
        self.view = screen
        
        // Cancel button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(cancelButton))
        // Done button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(doneButton))
        
        self.title = "Filter"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func doneButton() {
        self.viewModel.applyFilters()
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Data Source
extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCategoryCell", for: indexPath) as? FilterCategoryTableViewCell else {
            return UITableViewCell()
        }
        guard let cellViewModel = self.viewModel.viewModelForFilter(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.setViewModel(cellViewModel)
        
        return cell
    }
}

// MARK: - Delegate
extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = FilterOptionsViewModel(filter: self.viewModel.filters[indexPath.row])
        let optionsViewController = FilterOptionsViewController(viewModel: viewModel)
        
        self.navigationController?.pushViewController(optionsViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
