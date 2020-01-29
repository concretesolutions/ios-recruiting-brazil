//
//  FavoritesViewController.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 22/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    //MARK: - Variables
    var safeArea:UILayoutGuide!
    var listView:ListViewController!
    var isSearching:Bool = false
    var searchFilter:String = dao.filters[1]
    
    lazy var favoritesTableView:UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoriteMovieTableViewCell.self, forCellReuseIdentifier: "FavoriteCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        tableView.backgroundColor = UIColor.init(hex: dao.concreteGray)
        tableView.rowHeight = UITableView.automaticDimension
//        tableView.reloadData()
        return tableView
    }()
    
    lazy var filterTableView:UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.isHidden = true
        tableView.estimatedRowHeight = 200
        tableView.backgroundColor = UIColor.init(hex: dao.concreteGray)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
        return tableView
    }()
    
    lazy var searchBar:UISearchBar = {
          let searchBar = UISearchBar()
          view.addSubview(searchBar)
          searchBar.translatesAutoresizingMaskIntoConstraints = false
          searchBar.delegate = self
          searchBar.barTintColor = .clear
          searchBar.barStyle = .default
          searchBar.isTranslucent = true
          searchBar.enablesReturnKeyAutomatically = false
          searchBar.placeholder = "Search by \(searchFilter)"
          searchBar.showsCancelButton = true
          return searchBar
      }()
    
    lazy var filterButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        let normalButtonImage = UIImage(imageLiteralResourceName: "filter_icon")
        button.setImage(normalButtonImage, for: .normal)
        button.contentMode = .center
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(showFilterOptions), for: .touchDown)
        return button
    }()
    
    
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        safeArea = view.layoutMarginsGuide
        setContraints()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.favoritesTableView.reloadData()
    }
    
    //MARK: - Complimentary Methods
    
    @objc private func showFilterOptions(){
        if filterTableView.isHidden{
            filterTableView.isHidden = false
            self.view.bringSubviewToFront(self.filterTableView)
        }else{
            filterTableView.isHidden = true
        }
    }

    //MARK:- Constraints
    private func setContraints(){
        
        searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width/5).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: view.frame.height/8).isActive = true
        
        filterButton.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        filterButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        filterButton.rightAnchor.constraint(equalTo: searchBar.leftAnchor, constant: 0).isActive = true
        filterButton.heightAnchor.constraint(equalToConstant: view.frame.height/8).isActive = true
        
        filterTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 0).isActive = true
        filterTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        filterTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        filterTableView.heightAnchor.constraint(equalToConstant: view.frame.height/7).isActive = true
        
        favoritesTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 0).isActive = true
        favoritesTableView.bottomAnchor.constraint(equalTo:safeArea.bottomAnchor).isActive = true
        favoritesTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        favoritesTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
       
    }
    
}
//MARK: - Extensions
extension FavoritesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == favoritesTableView{
        if !isSearching{ return dao.favoriteMovies.count} else {return dao.filteredFavorites.count}
        }else{
            return dao.filters.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == favoritesTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteMovieTableViewCell
            if !isSearching{
                let movie = dao.favoriteMovies[indexPath.row]
                movie.isFavorite = false
                cell.setUp(movie:movie)
            }else{
                let movie = dao.filteredFavorites[indexPath.row]
                movie.isFavorite = false
                cell.setUp(movie:movie)
            }
            return cell
        }else{
            let cell = UITableViewCell()
            cell.textLabel?.text = dao.filters[indexPath.row]
            cell.backgroundColor = UIColor.init(hex: dao.concreteGray)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == favoritesTableView{
        return tableView.frame.height/3.5
        }else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
       if tableView == favoritesTableView{
        return 200
        }else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == favoritesTableView{
//        let movie = dao.favoriteMovies[indexPath.row]
//        let movieVc = MovieViewController()
//        movieVc.setMovie(movie: movie)
//        movieVc.delegate = self.listView
//        self.present(movieVc, animated: true) {
        //        } var movie = dao.searchResults[indexPath.row]
        var movie = dao.favoriteMovies[indexPath.row]
        if isSearching{movie = dao.filteredFavorites[indexPath.row]}
        
        let movieVc = MovieViewController()
        movieVc.setMovie(movie: movie)
        movieVc.delegate = self.listView
        
        self.present(movieVc, animated: true)
        }else{
            self.searchFilter = dao.filters[indexPath.row]
            self.filterTableView.isHidden = true
            self.searchBar.placeholder = "Search by \(searchFilter)"
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == favoritesTableView{
        let delete = deleteAction(at: indexPath)
        delete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [delete])
        }
        return UISwipeActionsConfiguration()
    }
    func deleteAction(at indexPath:IndexPath) ->UIContextualAction{
        
        let action = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            dao.favoriteMovies.remove(at: indexPath.row)
            let cell  = self.favoritesTableView.cellForRow(at: indexPath) as! FavoriteMovieTableViewCell
            for movieIndex in 0...dao.searchResults.count - 1{
                if cell.movie.id == dao.searchResults[movieIndex].id{
                    dao.searchResults[movieIndex].isFavorite = false
                    break
                }
            }
            self.favoritesTableView.reloadData()
        }
        return action
    }

}

extension FavoritesViewController:UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        favoritesTableView.reloadData()
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text{
            if text != ""{
                filterMovies(name: text, type: searchFilter)
                favoritesTableView.reloadData()
            }else{
                isSearching = false
                dao.filteredFavorites = []
                favoritesTableView.reloadData()
            }
        }else{
            isSearching = false
            dao.filteredFavorites = []
            favoritesTableView.reloadData()
        }
        searchBar.endEditing(true)
        favoritesTableView.reloadData()
    }
    
    
    func filterMovies(name:String,type:String){
        self.isSearching = true
        
        dao.filteredFavorites = []
        
        switch type {
        case "Genre":
            let url = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(dao.apiKey)&language=en-US"
            let anonymousFunc = {(fetchedData:GenreResult) in
                var movieIds:[String] = []
                //get genre names
                DispatchQueue.main.async {
                    for movie in dao.favoriteMovies{
                        for genre in fetchedData.genres{
                            for id in movie.genre_ids{
                                if genre.id == id{
                                    movieIds.append(genre.name)
                                }
                            }
                        }
                        for id in movieIds{
                            if id.lowercased() == name.lowercased(){
                                dao.filteredFavorites.append(movie)
                                break
                            }
                        }
                    }
                    self.favoritesTableView.reloadData()
                }
            }
            api.retrieveCategories(urlStr: url, view: self, onCompletion: anonymousFunc)
        case "Year":
            for movie in dao.favoriteMovies{
                let year = movie.release_date.components(separatedBy: "-")[0]
                if year == name{
                    dao.filteredFavorites.append(movie)
                }
            }
        
        case "Title":
    
            for movie in dao.favoriteMovies{
                if movie.title.lowercased().contains(name.lowercased()){
                    dao.filteredFavorites.append(movie)
                }
            }
            
        default:
            debugPrint("not a correct value")
        }
        
        
    }
    
}




