//
//  FavoriteMoviesViewController.swift
//  Movies
//
//  Created by Matheus Queiroz on 1/11/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: UITableViewController {

    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    var model: FavoriteMoviesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingActivityIndicator.startAnimating()
        loadingActivityIndicator.hidesWhenStopped = true;
        model = FavoriteMoviesViewModel.init(viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        model?.verifyIfFavoritesIsUpdated()
        self.tabBarController?.navigationItem.title = "Favorites"
        self.tabBarController?.navigationItem.searchController = nil
        self.tableView.reloadData()
    }
    
    open func didUpdateFavoriteMovies(){
        self.tableView.reloadData()
        loadingActivityIndicator.stopAnimating()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.favoriteMoviesArray.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMovieCell", for: indexPath) as? FavoriteMoviesTableViewCell else {
            fatalError("Not a favorite movie Cell")
        }

        let movieToSetup = model?.favoriteMoviesArray[indexPath.row]
        cell.setupForMovie(Movie: movieToSetup!)

        return cell
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let movieToDelete = model?.favoriteMoviesArray[indexPath.row]
        let deleteAction = UITableViewRowAction(style: UITableViewRowAction.Style.default, title: "Remove") { (action: UITableViewRowAction, indexPath: IndexPath) in
            let deleteMenu = UIAlertController(title: "Remove From Favorites", message: "Are you sure you want to remove \(movieToDelete!.title) from your favorites?", preferredStyle: UIAlertController.Style.actionSheet)
            let removeAction = UIAlertAction(title: "Remove", style: UIAlertAction.Style.destructive, handler: { (action) in
                self.model?.remove(fromFavorites: movieToDelete!)
                self.tableView.reloadData()
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            
            deleteMenu.addAction(removeAction)
            deleteMenu.addAction(cancelAction)
            
            self.present(deleteMenu, animated: true, completion: nil)
        }
        return [deleteAction]
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedCell = sender as! FavoriteMoviesTableViewCell
        let selectedCellIndexPath = self.tableView.indexPath(for: selectedCell)
        let selectedMovie = model?.favoriteMoviesArray[selectedCellIndexPath!.row]
        
        let destinationViewController = segue.destination as! DetailsViewController
        destinationViewController.selectedMovie = selectedMovie
    }
}
