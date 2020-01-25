//
//  FavoritesViewController.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 22/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    
    var safeArea:UILayoutGuide!
    
    //MARK: - Variables
    lazy var tableView:UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoriteMovieTableViewCell.self, forCellReuseIdentifier: "FavoriteCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        tableView.backgroundColor = .lightGray
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
        return tableView
    }()
    
    
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .purple
        safeArea = view.layoutMarginsGuide
        setContraints()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    private func setContraints(){
        
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo:safeArea.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
}
//MARK: - Extensions
extension FavoritesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dao.favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteMovieTableViewCell
        cell.setUp(movie: dao.favoriteMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height/3.5
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = dao.searchResults[indexPath.row]
        let movieVc = MovieViewController()
        movieVc.setMovie(movie: movie)
        movieVc.delegate = ListViewController()
//        movieVc.cellIndexPath = movie.listIndexPath
        self.present(movieVc, animated: true) {
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        delete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [delete])
        
    }
    func deleteAction(at indexPath:IndexPath) ->UIContextualAction{
        
        let action = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            dao.favoriteMovies.remove(at: indexPath.row)
            let cell  = self.tableView.cellForRow(at: indexPath) as! FavoriteMovieTableViewCell
            for movieIndex in 0...dao.searchResults.count - 1{
                if cell.movie.id == dao.searchResults[movieIndex].id{
                    dao.searchResults[movieIndex].isFavorite = false
                    break
                }
            }
            
            self.tableView.reloadData()
        }
        return action
    }

}


