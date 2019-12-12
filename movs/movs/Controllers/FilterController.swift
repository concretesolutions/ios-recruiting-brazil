//
//  FilterController.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class FilterController: UIViewController {
    // MARK: - Attributes
    lazy var screen = FilterScreen(delegate: self)
    let dataService = DataService.shared
    let filterType: FilterType
    let filterValues: [String]
    var selectedValue: String?
    
    // MARK: - Initializers
    required init(filterType: FilterType, selectedValue: String?) {
        self.filterType = filterType
        self.selectedValue = selectedValue
        
        switch self.filterType {
        case .date:
            let movieMinYear = self.dataService.favorites.min { (lmovie, rmovie) -> Bool in
                return Int(lmovie.releaseDate)! < Int(rmovie.releaseDate)!
            }
            
            if let minYear = Int(movieMinYear?.releaseDate ?? "") {
                let currentYear = Int(Calendar.current.component(.year, from: Date()))
                self.filterValues = Array(minYear...currentYear).map({ year in String(year)})
            } else {
                self.filterValues = []
            }
        case .genre:
            self.filterValues = Array(self.dataService.genres.values)
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View controller life cycle
    override func loadView() {
        super.loadView()
        self.view = self.screen
        switch self.filterType {
        case .date:
            self.title = "Date"
        case .genre:
            self.title = "Genres"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let controller = self.navigationController?.visibleViewController as? FiltersController {
            controller.filters[self.filterType] = self.selectedValue ?? ""
        }
        super.viewWillDisappear(animated)
    }
}

extension FilterController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let value = self.filterValues[indexPath.row]
        
        cell.textLabel?.text = value
        cell.selectionStyle = .none
        cell.tintColor = .label
        if value == self.selectedValue {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
}

extension FilterController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)!
        // Check if exists a selected value
        if let selectedValue = self.selectedValue,
            let index = self.filterValues.firstIndex(of: selectedValue) {
            
            // Get cell with last selected value
            let lastSelectedCell = tableView.cellForRow(at: IndexPath(item: index, section: 0))!
            lastSelectedCell.accessoryType = .none
            
            // If the selected cell was the last selected cell remove value
            // Don't update value/add checkmark
            if selectedValue == selectedCell.textLabel?.text {
                self.selectedValue = nil
                return
            }
        }
        self.selectedValue = self.filterValues[indexPath.row]
        selectedCell.accessoryType = .checkmark
    }
}
