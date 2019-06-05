//
//  FavoritesViewController.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 04/06/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var tableViewFavorites: UITableView!
    
    private static let numberOfSections = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDelegateAndDataSource()
        registerNibForTableViewCell()
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableViewDelegateAndDataSource() {
        self.tableViewFavorites.delegate = self
        self.tableViewFavorites.dataSource = self
    }
    
    func registerNibForTableViewCell() {
        tableViewFavorites.registerNibForTableViewCell(FavoritesTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoritesViewController.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewFavorites.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.reusableIdentifier, for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}
