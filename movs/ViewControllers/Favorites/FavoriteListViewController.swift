//
//  FavoriteListViewController.swift
//  movs
//
//  Created by Renan Oliveira on 17/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

class FavoriteListViewController: UIViewController {
    static let identifier = "FavoriteListViewControllerID"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var textEmptyView: UILabel!
    
    private let presenter: FavoriteListPresenter = FavoriteListPresenter()
    private var movies: [MovieData] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.loadFavoriteMovies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.presenter.attach(view: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupTableView() {
        self.tableView.register(FavoriteTableViewCell.nib, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        self.tableView.tableFooterView = UIView()
    }
}

extension FavoriteListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.filter(text: searchText)
    }
}

extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as! FavoriteTableViewCell
        cell.prepareCell(movie: self.movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MovieRouter.pushMovieDetailViewController(self, movie: self.movies[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let unFavoriteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Unfavorite" , handler: { (action:UITableViewRowAction, indexPath:IndexPath) -> Void in
            self.presenter.unFavorite(movieId: self.movies[indexPath.row].id)
        })
        return [unFavoriteAction]
    }
}

extension FavoriteListViewController: FavoriteListViewProtocol {
    func onLoadedFavoriteMovies(movies: [MovieData]) {
        self.movies = movies
        self.tableView.reloadData()
    }
    
    func onFilterResult(movies: [MovieData]) {
        self.movies = movies
        self.tableView.reloadData()
        UIView.animate(withDuration: 0.3) {
            self.emptyView.alpha = 0.0
        }
    }
    
    func onFilterEmptyResult() {
        self.textEmptyView.text = "Sua busca por \"\(self.searchBar.text!)\" não resultou em nenhum resultado."
        UIView.animate(withDuration: 0.3) {
            self.emptyView.alpha = 1.0
        }
    }
}
