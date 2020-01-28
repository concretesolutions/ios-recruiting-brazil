//
//  FavoriteViewController.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 21/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let favoriteViewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        touchScreenHideKeyboard()
        favoriteViewModel.delegate = self
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.activityStartAnimating()
        loadFavoriteMovies()
    }
    
    public func loadFavoriteMovies(){
        favoriteViewModel.readCoreData(completionHandler: { reload in
            self.configureUI()
        })
    }

    public func configureUI(){
        tableView.reloadData()
        view.activityStopAnimating()
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteViewModel.arrayMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = FavoriteTableViewCell()
        guard let cell = Bundle.main.loadNibNamed(movieCell.identiifier, owner: self, options: nil)?.first as? FavoriteTableViewCell else { return UITableViewCell()}
        
        cell.movie = favoriteViewModel.getMovie(indexPath: indexPath)
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let unfavorite = unfavoriteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [unfavorite])
    }
    
    private func unfavoriteAction(at indexPath: IndexPath) -> UIContextualAction {
        let unfavorite = UIContextualAction(style: .destructive, title: "Unfavorite") { (action, View, completionHandler) in
            let movie = self.favoriteViewModel.arrayMovies[indexPath.row]
            self.favoriteViewModel.arrayMovies.remove(at: indexPath.row)
            self.favoriteViewModel.unfavorite(movie: movie)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        return unfavorite
    }
    
}

extension FavoriteViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        favoriteViewModel.search(searchText: searchText, completionHandler: { result in
            if result {
                self.tableView.reloadData()
            }
        })
    }
}
