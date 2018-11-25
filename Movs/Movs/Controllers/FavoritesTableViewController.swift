//
//  FavoritesTableViewController.swift
//  Movs
//
//  Created by Julio Brazil on 24/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FavoriteCell"

class FavoritesTableViewController: UITableViewController {
    var favorites = [Movie]()
    
    var filteredFavorites = [Movie]()
    var isFiltering: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        // Get favorites
        self.favorites = FavoriteManager.shared.favorites
        
        // Set filter button
        self.navigationItem.rightBarButtonItem = {
            let button = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.displayFilter))
            return button
        }()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.favorites = FavoriteManager.shared.favorites
        
        self.filteredFavorites = self.filteredFavorites.filter(self.favorites.contains)
        
        self.tableView.reloadData()
    }
    
    // MARK: - custom methods
    
    @objc func displayFilter() {
        //TODO:
        let vc = FilterTableViewController(filtering: self.favorites, completion: { (filtered) in
            self.filteredFavorites = filtered
            self.isFiltering = true
        })
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func removeFilter() {
        self.filteredFavorites = []
        self.isFiltering = false
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
