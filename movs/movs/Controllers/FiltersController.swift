//
//  FiltersController.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class FiltersController: UIViewController {
    // MARK: - Attributes
    lazy var screen = FiltersScreen(controller: self)
    var filters: [FilterType: String?] = [:]
    
    // MARK: - Initializers
    required init(filters: [FilterType: String]) {
        super.init(nibName: nil, bundle: nil)
        FilterType.allCases.forEach { (filterType) in
            if let value = filters[filterType] {
                self.filters[filterType] = value
            } else {
                self.filters[filterType] = ""
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View controller life cycle
    override func loadView() {
        super.loadView()
        self.title = "Filters"
        self.view = self.screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.screen.filtersTableView.reloadData()
        super.viewWillAppear(animated)
    }
    
    // MARK: - Apply filters action
    @objc func applyFilters() {
        self.navigationController?.popViewController(animated: true)
        if let controller = self.navigationController?.visibleViewController as? FavoritesController {
            self.filters.forEach { (key, value) in
                controller.filters[key] = value == "" ? nil : value
            }
        }
    }
}

// MARK: - Table view data source
extension FiltersController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        if let filterType = FilterType(rawValue: indexPath.row) {
            cell.textLabel?.text = filterType.stringValue
            cell.detailTextLabel?.text = self.filters[filterType] ?? nil
        }
        return cell
    }
}

// MARK: - Table view delegate
extension FiltersController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filterType = FilterType(rawValue: indexPath.row)!
        let filterController = FilterController(filterType: filterType, selectedValue: self.filters[filterType] ?? nil)
        self.navigationController?.pushViewController(filterController,
                                                      animated: true)
    }
}
