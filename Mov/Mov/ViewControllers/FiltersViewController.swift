//
//  FiltersViewController.swift
//  Mov
//
//  Created by Allan on 09/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

protocol FiltersViewControllerDelegate {
    func didApplyFilters(filters: [Filter])
}

final class FiltersViewController: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet weak private var tableView: UITableView!
    
     //MARK: - Actions
    @IBAction private func ApplyFilter(_ sender: UIButton) {
        self.delegate?.didApplyFilters(filters: self.items)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Variables
    var items = [Filter]()
    var availableYears = Set<String>()
    var availableGenres = Set<String>()
    var delegate: FiltersViewControllerDelegate?
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupInterface() {
        super.setupInterface()
        currentTitle = "Filters"
        tableView.register(UINib(nibName: "SelectActionTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectActionTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
        
        if self.items.isEmpty{
            if !availableYears.isEmpty{
                var item = Filter(property: "Dates")
                item.values = Array(availableYears)
                items.append(item)
            }
            
            if !availableGenres.isEmpty{
                var item = Filter(property: "Genres")
                item.values = Array(availableGenres)
                items.append(item)
            }
        }
    }
    
    private func showFilterSelector(with filter: Filter){
        let vc = storyboard?.instantiateViewController(withIdentifier: "filterSelectionVC") as! FilterSelectionViewController
        vc.filter = filter
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - FilterSelectionViewControllerDelegate
extension FiltersViewController: FilterSelectionViewControllerDelegate{
    func didSelectFilter(filter: Filter) {
        if let index = items.index(of: filter){
            items[index] = filter
            tableView.reloadData()
        }
    }
}

//MARK: - TableView DataSource, Delegate

extension FiltersViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectActionTableViewCell", for: indexPath) as! SelectActionTableViewCell
        let filter = items[indexPath.row]
        cell.setup(with: filter.property, subtitle: filter.selectedValues.compactMap({String($0)}).joined(separator: ", "))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showFilterSelector(with: items[indexPath.row])
    }
}
