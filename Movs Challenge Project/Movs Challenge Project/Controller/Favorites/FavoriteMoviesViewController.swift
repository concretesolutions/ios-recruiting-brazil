//
//  FavoriteMoviesViewController.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 17/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: UIViewController {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initController()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    
    private var favoriteView: FavoriteMoviesView {
        return self.view as! FavoriteMoviesView
    }
    
    private var favoriteMovies: [Movie] {
        return TmdbAPI.movies.filter({$0.isFavorite}).sorted(by: {$0.title < $1.title})
    }
    
    private var isDeletingWithCommit: Bool = false
    
    // Private Methods
    
    private func initController() {
        self.view = FavoriteMoviesView()
        
        favoriteView.tableView.dataSource = self
        favoriteView.tableView.delegate = self
        favoriteView.tableView.register(FavoriteMovieTableViewCell.self, forCellReuseIdentifier: FavoriteMovieTableViewCell.reuseIdentifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateFavoriteInformation), name: Movie.favoriteInformationDidChangeNN, object: nil)
    }
    
    @objc func didUpdateFavoriteInformation() {
        if !self.isDeletingWithCommit {
            DispatchQueue.main.async {
                self.favoriteView.tableView.reloadData()
            }
        }
    }
}

// MARK: - TableView Delegate
extension FavoriteMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieTableViewCell.reuseIdentifier) as! FavoriteMovieTableViewCell
        cell.fill(movie: self.favoriteMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FavoriteMovieTableViewCell.rowHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Unfavorite") { (action, indexPath) in
            self.isDeletingWithCommit = true
            self.favoriteMovies[indexPath.row].isFavorite = false
            DispatchQueue.main.async {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            self.isDeletingWithCommit = false
        }

        return [delete]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("delete?")
        }
    }
}
