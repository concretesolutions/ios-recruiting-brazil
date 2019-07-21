//
//  FavoritesViewController.swift
//  Mov
//
//  Created by Victor Leal on 18/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    let screen = FavoritesViewControllerScreen()
    let network = RequestMovies.shared
    let userDefaults = SalvedDatas.shared
    var moviesFilter: [Result] = []
    
    override func loadView() {
        self.view = screen
        //self.view.backgroundColor = .blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen.favoritesTableView.delegate = self
        screen.favoritesTableView.dataSource = self
        
        loadData()
        filterData()
    }
    
    func loadData(){
        network.request()
    }
    
    func filterData(){
        moviesFilter = filterMovies()
    }
    
    func filterMovies() -> [Result]{
        
        var moviesFilter: [Result] = []
        
        if let results = network.results{
            
            
            for movie in results{
                if let titleM = movie.title{
                    print(titleM)
                    if favoriteMovies[titleM] ?? false{
                        print(titleM)
                        moviesFilter.append(movie)
                    }
                    
                }
                
            }
            
            return moviesFilter
            
        }
        return []
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as! FavoriteTableViewCell
        
        
        cell.title.text = moviesFilter[indexPath.row].title ?? "title not found"
        cell.movieDescription.text = moviesFilter[indexPath.row].overview ?? "description not found"
        cell.year.text = moviesFilter[indexPath.row].releaseDate ?? "????"
        
        
        cell.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.00)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeFavoriteSalve(movie: moviesFilter[indexPath.row])
            moviesFilter.remove(at: indexPath.row)
            screen.favoritesTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: "Unfavorite") { (action, indexPath) in
            self.screen.favoritesTableView.dataSource?.tableView!(self.screen.favoritesTableView, commit: .delete, forRowAt: indexPath)
            return
        }
        //deleteButton.backgroundColor = UIColor.black
        return [deleteButton]
    }
    
    func removeFavoriteSalve(movie: Result){
        
        if let title = movie.title{
            favoriteMovies[title] = false
            
            var favoriteMoviesUserDefaults = userDefaults.favoriteMovies
            favoriteMoviesUserDefaults = favoriteMoviesUserDefaults.filter{$0 != title}
            userDefaults.favoriteMovies = favoriteMoviesUserDefaults
        }
        
    }
    
    
    
}







