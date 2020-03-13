//
//  FavoritesTableViewController.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 12/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    private let reuseIdentifier = "favcell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

        self.tableView.backgroundColor = .blue
        // self.clearsSelectionOnViewWillAppear = false

        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

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

}
