//
//  FavoritesViewController.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 03/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    fileprivate var movies: [Movie] = []
    @IBOutlet weak var moviesTableView: UITableView!
    var presenter = FavoriteMoviesPresenter()
    @IBOutlet weak var clearFilterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        presenter.attach(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadData()
    }

    @IBAction func filterTapped(_ sender: Any) {
        self.presenter.getFilterView()
    }
    @IBAction func clearFilterTapped(_ sender: Any) {
        self.presenter.clearFilter()
    }
}

fileprivate extension FavoritesViewController {
    func setupTableView() {
        moviesTableView.register(FavoritedMovieTableViewCell.nib,
                                 forCellReuseIdentifier: FavoritedMovieTableViewCell.reuseIdentifier)
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.tableFooterView = UIView()
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritedMovieTableViewCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? FavoritedMovieTableViewCell {
            cell.set(movies[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        self.navigationController?.pushViewController(MovieDetailPresenter.initView(with: movie), animated: true)
    }
}

extension FavoritesViewController: FavoriteMoviesViewProtocol {
    func present(filterView: FilterBaseViewController) {
        let navigation = UINavigationController(rootViewController: filterView)
        navigation.navigationBar.barTintColor = UIColor.moviesAppYellow
        navigation.navigationBar.tintColor = UIColor.moviesAppBlack
        self.present(navigation, animated: true, completion: nil)
    }
    
    func set(movies: [Movie], filtered: Bool) {
        self.movies = movies
        self.moviesTableView.reloadData()
        clearFilterButton.isHidden = !filtered
    }
}
