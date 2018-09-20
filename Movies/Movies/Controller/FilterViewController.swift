//
//  FilterViewController.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    private let items = ["Date", "Genres"]

    private unowned var filterView: FilterView { return self.view as! FilterView }
    private unowned var tableView:  UITableView{ return filterView.tableView     }
    
    override func loadView() {
        self.view = FilterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureNavigationBar()
    }
    
    /// Adds the close button and title to the Controller
    private func configureNavigationBar(){
        self.title = "Filter"
        let close = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeViewController))
        self.navigationItem.leftBarButtonItem = close
    }
    
    /// Sets up the tableview
    private func setupTableView(){
        tableView.delegate   = self
        tableView.dataSource = self
        
        let footer = FilterFooterCell(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        footer.buttonApply.addTarget(self, action: #selector(applyFilters), for: .touchUpInside)
        tableView.tableFooterView = footer
    }
    
    /// Apply the filters
    @objc private func applyFilters(){
        closeViewController()
    }
    
    /// Opens the FilterController
    @objc private func closeViewController(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.identifier, for: indexPath) as? FilterCell else{
            return UITableViewCell()
        }
        cell.title.text = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
