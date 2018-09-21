//
//  FilterViewController.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class FilterViewController: UITableViewController {
    
    /// The filters'options
    private let items = [(name: "Date", type: FilterOption.date), (name: "Genre", type: FilterOption.genre)]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    /// Adds the close button and title to the Controller
    private func configureNavigationBar(){
        self.title = "Filter"
        let close = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeViewController))
        self.navigationItem.leftBarButtonItem = close
    }
    
    /// Sets up the tableview
    private func setupTableView(){
        self.tableView.register(FilterCell.self, forCellReuseIdentifier: FilterCell.identifier)
        let footer = FilterFooterCell(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        footer.buttonApply.addTarget(self, action: #selector(applyFilters), for: .touchUpInside)
        tableView.tableFooterView = footer
    }
    
    /// Apply the filters
    @objc private func applyFilters(){
        Filter.current.hasFilters = true
        closeViewController()
    }
    
    /// Opens the FilterController
    @objc private func closeViewController(){
        if !Filter.current.hasFilters{
            Filter.current.resetAll()
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.identifier, for: indexPath) as? FilterCell else{
            return UITableViewCell()
        }
        cell.setupCell(item: items[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let filterDetail = FilterDetailViewController()
        switch items[indexPath.row].type {
            case .date:
                filterDetail.filterOption = .date
            case .genre:
                filterDetail.filterOption = .genre
        }
        navigationController?.pushViewController(filterDetail, animated: true)
    }
}
