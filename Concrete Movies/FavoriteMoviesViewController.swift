//
//  FavoriteMoviesViewController.swift
//  Concrete Movies
//
//  Created by Lucas Daniel on 28/08/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import UIKit

class FavoritesMoviesCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieImageWidth: NSLayoutConstraint!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
}

class FavoriteMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var stack = CoreDataStack.shared
    
    var handleMovie = HandleMovie()
    
    var favoriteMovies: [MovieDetail?] = []
    
    @IBOutlet weak var favoriteMoviesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.favoriteMoviesTable.delegate = self
        self.favoriteMoviesTable.dataSource = self
        
        if let favoriteMovies = loadFavorites() {
            self.favoriteMovies = favoriteMovies
            self.favoriteMoviesTable.reloadData()
        }
        
    }
    
    private func loadFavorites() -> [MovieDetail]? {
        var movieDetail: [MovieDetail]?
        do {
            try movieDetail = handleMovie.fetchMovie(entityName: "MovieDetail", viewContext: stack.viewContext)
            self.favoriteMovies = movieDetail!
        } catch {
            print("Erro")
        }
        return movieDetail
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Screen.screenHeight*30/100
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoritesMoviesCell
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + (self.favoriteMovies[indexPath.row]?.poster_path)!)
        cell.movieImage.kf.setImage(with: url)
        
        cell.movieName.text = self.favoriteMovies[indexPath.row]?.title!
        cell.movieReleaseDate.text = self.favoriteMovies[indexPath.row]?.release_date!.take(4)
        cell.movieOverview.text = self.favoriteMovies[indexPath.row]?.overview!
        
        cell.movieImageWidth.constant = Screen.screenWidth*30/100
        
        return cell
    }

}

extension String {
    func take(_ n: Int) -> String {
        guard n >= 0 else {
            fatalError("n should never negative")
        }
        let index = self.index(self.startIndex, offsetBy: min(n, self.count))
        return String(self[..<index])
    }
}
