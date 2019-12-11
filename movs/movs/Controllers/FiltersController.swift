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
    lazy var screen = FiltersScreen(delegate: self)
    
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
}

extension FiltersController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Date"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Genres"
        }
        
        return cell
    }
}

extension FiltersController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filterType = FilterType(rawValue: indexPath.row)
        let filterController = FilterController(filterType: filterType!)
        self.navigationController?.pushViewController(filterController,
                                                      animated: true)
    }
}
