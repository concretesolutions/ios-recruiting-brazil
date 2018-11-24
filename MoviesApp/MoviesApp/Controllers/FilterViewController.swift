//
//  FilterViewController.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 23/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit



class FilterViewController: UIViewController {
    
    let screen = FilterScreen()
    var items:[String]
    var selectedItems:[String]
    var filterType:FilterType
    
    var delegate:FilterManagerDelegate?
    
    init(items: [String], type: FilterType, selectedItems: [String]){
        self.items = items
        self.filterType = type
        self.selectedItems = selectedItems
        super.init(nibName: nil, bundle: nil)
        switch type {
        case .year:
            self.title = "By Year"
        case .genre:
            self.title = "By Genre"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.screen.tableView.setupTableView(with: items, selected: selectedItems)
//        self.screen.tableView.setupTableView(with: persistedMovies)
    }
    
    override func loadView() {
        self.view = screen
    }

    override func viewWillDisappear(_ animated: Bool) {
        delegate?.setFilter(ofType: filterType, with: screen.getSelectedItems())
    }

}
