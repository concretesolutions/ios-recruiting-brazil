//
//  FilterViewController.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    private unowned var filterView: FilterView{ return self.view as! FilterView }
    
    //    private unowned var tableView:     UITableView      { return favoriteMoviesView.tableView      }
    //    private unowned var refreshControl:UIRefreshControl { return favoriteMoviesView.refreshControl }
    
    override func loadView() {
        self.view = FilterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Adds the close button to the Controller
    private func setFilterButton(){
        let close = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeViewController))
        self.navigationItem.leftBarButtonItem = close
    }
    
    /// Opens the FilterController
    @objc private func closeViewController(){
        self.dismiss(animated: true, completion: nil)
    }
}
