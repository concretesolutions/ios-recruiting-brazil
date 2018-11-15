//
//  FavoritesTableViewController.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 15/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UIViewController {
    
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let filterButtonRightBarButton =  UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: self, action: #selector(filterAction(_:)))
    var middle: FavoriteMoviesMiddle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        middle = FavoriteMoviesMiddle(delegate: self)
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        searchBar.delegate = self
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func alertNoItemsToBeFetched() {
        let alert = UIAlertController(title: "Any saved game", message: "You don't have any saved game", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
    
    @objc func filterAction(_ sender: String) {
        
    }
 

}

extension FavoritesTableViewController: UITableViewDelegate {
    
}

extension FavoritesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return middle.favoritesFetched.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorite", for: indexPath) as! PopularMoviesTableViewCell
        cell.configure(with: middle.movieData(at: indexPath.row))
        return cell
    }
}

extension FavoritesTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    
}

extension FavoritesTableViewController: FavoriteMoviesMiddleDelegate {
    
    func favoritesFetched() {
        if middle.favoritesFetched.count == 0 {
            alertNoItemsToBeFetched()
            filterButtonRightBarButton.isEnabled = false
        }
    }
    
    func savedMovie() {
        self.dismiss(animated: true, completion: nil)
    }
}
