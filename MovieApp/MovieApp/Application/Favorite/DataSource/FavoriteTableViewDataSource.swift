//
//  FavoriteTableViewDataSource.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 12/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

protocol FavoriteDataSourceDelegate: class {
    func didSelected(movie: Movie)
    func editStyle(movie: Movie)
}

final class FavoriteTableViewDataSource: NSObject {
    
    private weak var tableView: UITableView?
    private let delegate: FavoriteDataSourceDelegate
    private var movies: [Movie] = []
    
    init(tableView: UITableView, delegate: FavoriteDataSourceDelegate) {
        self.delegate = delegate
        
        super.init()
        self.tableView = tableView
        registerCells()
        setupDataSource()
        
    }
    
    private func registerCells() {
        tableView?.register(FavoriteCell.self, forCellReuseIdentifier: Strings.favoriteCell)
    }
    
    private func setupDataSource() {
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
    func updateMovies(movies: [Movie]) {
        self.movies = movies
        tableView?.reloadData()
    }
    
}

extension FavoriteTableViewDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate.editStyle(movie: movies[indexPath.row])
        }
    }
    
}

extension FavoriteTableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FavoriteCell = tableView.dequeueReusableCell(withIdentifier: Strings.favoriteCell, for: indexPath) as? FavoriteCell else { return UITableViewCell()}
        let movie = movies[indexPath.row]
        cell.setupCell(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelected(movie: movies[indexPath.row])
    }
    
}

