//
//  FavoritesTableViewController.swift
//  DesafioConcrete
//
//  Created by Ian Manor on 18/12/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    @IBOutlet var headerView: UIView!
    
    var favoriteMovies: [Movie] = []
    var filteredMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteMovies = []
        filteredMovies = []
        
        if FilterSettings.shared.isOn == false {
            tableView.tableHeaderView = nil
        } else {
            tableView.tableHeaderView = headerView
        }
        
        let client = TMDBClient()
        
        for favorite in UserFavorites.shared.favorites {
            client.loadMovieDetails(movieId: favorite) { (result, error) in
                if let result = result {
                    let movie = Movie(movieResult: result)
                    self.favoriteMovies.append(movie)
                    
                    var shouldFilterByDate = false
                    if let filterDate = FilterSettings.shared.date {
                        if movie.releaseDate != filterDate {
                            shouldFilterByDate = true
                        }
                    }
                    
                    var shouldFilterByGenre = false
                    if let filterGenre = FilterSettings.shared.genre {
                        if let movieGenres = movie.genres {
                            shouldFilterByGenre = true
                            
                            for genre in movieGenres {
                                if case genre.id = filterGenre {
                                    shouldFilterByGenre = false
                                    break
                                }
                            }
                        } else {
                            shouldFilterByGenre = true
                        }
                    }
                    
                    if !shouldFilterByDate && !shouldFilterByGenre {
                        self.filteredMovies.append(movie)
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("Could not load movie with id \(favorite)")
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if FilterSettings.shared.isOn {
            return filteredMovies.count
        } else {
            return favoriteMovies.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteMovieTableViewCell

        var movie: Movie
        
        if FilterSettings.shared.isOn {
            movie = filteredMovies[indexPath.row]
        } else {
            movie = favoriteMovies[indexPath.row]
        }
        
        cell.titleLabel.text = movie.title
        cell.releaseDateLabel.text = movie.releaseDate
        cell.descriptionLabel.text = movie.description
        
        if let posterPath = movie.posterPath {
            let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
            let data = try? Data(contentsOf: imageURL!)
            cell.posterImageView.image = UIImage(data: data!)
        } else {
            cell.posterImageView.image = nil
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Unfavorite") { (rowAction, indexPath) in
            
            if FilterSettings.shared.isOn {
                if let unfavoritedMovieId = self.filteredMovies[indexPath.row].id {
                    UserFavorites.shared.remove(id: unfavoritedMovieId)
                }
                
                self.filteredMovies.remove(at: indexPath.row)
            } else {
                if let unfavoritedMovieId = self.favoriteMovies[indexPath.row].id {
                    UserFavorites.shared.remove(id: unfavoritedMovieId)
                }
                
                self.favoriteMovies.remove(at: indexPath.row)
            }
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = UIColor(red: 208/255, green: 18/255, blue: 27/255, alpha: 1)
        
        return [deleteAction]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    @IBAction func removeFilters(_ sender: Any) {
        FilterSettings.shared.isOn = false
        tableView.tableHeaderView = nil
        tableView.reloadData()
    }
    
}
