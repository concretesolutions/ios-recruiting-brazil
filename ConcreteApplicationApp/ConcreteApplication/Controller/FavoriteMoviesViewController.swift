//
//  FavoriteMoviesViewController.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 26/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import SnapKit

class FavoriteMoviesViewController: UIViewController {
    
    var tableView = FavoriteMoviesTableView()
    var tableViewDelegate: FavoriteMoviesTableViewDelegate?
    var tableViewDataSource: FavoriteMoviesTableViewDataSource?
    
    var favoritedMovies:[Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavoriteMovies()
        self.tableView.reloadData()
    }
    
    func getFavoriteMovies(){
        self.favoritedMovies = []
        let favoriteMoviesRealm = RealmManager.shared.getAll(objectsOf: MovieRealm.self)
        favoriteMoviesRealm.forEach({self.favoritedMovies.append(Movie(realmObject: $0))})
        self.setupTableView(with: self.favoritedMovies)
    }
    
    func setupTableView(with movies: [Movie]){
        tableViewDelegate = FavoriteMoviesTableViewDelegate(favoritedMovies: movies, delegate: self)
        self.tableView.delegate = tableViewDelegate
        tableViewDataSource = FavoriteMoviesTableViewDataSource(favoritedMovies: movies, tableView: self.tableView)
        self.tableView.dataSource = tableViewDataSource
        self.tableView.reloadData()
    }
    
    @objc
    func pushFilterOptions(){
        let filterViewController = FilterOptionsViewController(movies: favoritedMovies)
        filterViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(filterViewController, animated: true)
    }
    
}

extension FavoriteMoviesViewController: CodeView{
    
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: self, action: #selector(pushFilterOptions))
    }
    
}

extension FavoriteMoviesViewController: UnfavoriteMovieDelegate{
    
    func deleteRowAt(indexPath: IndexPath) {
        if let movieToDelete = RealmManager.shared.get(objectOf: MovieRealm.self, with: self.favoritedMovies[indexPath.row].id){
            RealmManager.shared.delete(object: movieToDelete)
            tableViewDataSource?.favoritedMovies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
