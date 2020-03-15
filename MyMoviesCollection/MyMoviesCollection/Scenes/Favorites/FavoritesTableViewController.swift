//
//  FavoritesTableViewController.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 12/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController, Alerts {

    // MARK: - Properties
    
    private let reuseIdentifier = "favcell"

    // MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navTopItem = navigationController?.navigationBar.topItem {
            navTopItem.titleView = .none
            navTopItem.title = "Favorites"
        }
        
    }

    // MARK: - TableView DataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FavoritesTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {

        }
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
         return "Unfavorite"
    }

}
