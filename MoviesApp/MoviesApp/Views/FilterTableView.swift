//
//  FilterTableView.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 23/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit

class FilterTableView: UITableView {
    
    fileprivate var customDataSource:FilterDataSource?
    fileprivate var customDelegate:FilterTableDelegate?
    
    convenience init() {
        self.init(frame: .zero)
        self.allowsMultipleSelection = true
        customDelegate = FilterTableDelegate()
        customDataSource = FilterDataSource(items: [], selectedItems: [], tableView: self, delegate: customDelegate!)
        
    }
    
    func setupTableView(with items:[String], selected:[String]){
        self.customDataSource = FilterDataSource(items: items, selectedItems: selected, tableView: self, delegate: customDelegate!)
    }
    
    func getSelectedItems() -> [String]{
        return customDataSource?.getSelectedItems() ?? []
    }

}
