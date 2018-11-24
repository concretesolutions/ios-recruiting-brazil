//
//  FilterDataSource.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 23/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation
import UIKit

final class FilterDataSource:NSObject{
    
    var items:[String] = []
    var selectedItems:[String] = []
    weak var delegate:FilterTableDelegate?
    weak var tableView:UITableView?
    
    required init(items:[String], selectedItems:[String], tableView:UITableView, delegate:FilterTableDelegate){
        self.items = items
        self.selectedItems = selectedItems
        self.tableView = tableView
        self.delegate = delegate
        delegate.tableView = tableView
        super.init()
        delegate.dataSource = self
        tableView.register(cellType: FilterTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = delegate
        tableView.reloadData()
    }
    
    func getSelectedItems() -> [String]{
        var selectedItems:[String] = []
        if let selectedIndexes = self.tableView?.indexPathsForSelectedRows{
            for index in selectedIndexes{
                selectedItems.append(items[index.row])
            }
        }
        return selectedItems
    }
    
}

extension FilterDataSource: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FilterTableViewCell.self)
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        cell.textLabel?.text = items[indexPath.row]
        let item  = items[indexPath.row]
        cell.setup(for: item)
        if selectedItems.contains(item){
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }else{
            tableView.deselectRow(at: indexPath, animated: false)
        }
        return cell
    }
    
}
