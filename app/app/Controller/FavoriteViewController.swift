//
//  FavoriteViewController.swift
//  app
//
//  Created by rfl3 on 23/12/19.
//  Copyright © 2019 Renan Freitas. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    
    @IBOutlet weak var movieImage: UIImageView!
    var moviesIds: [Int]? {
        didSet {
            guard let ids = self.moviesIds else { return }
            ids.forEach({ RequestService.shared.getMovie($0) })
        }
    }
    
    var allMovies: [Movie] = []
    var movies: [Movie] = []
    var genres: [Int: String] = [:]
    
    override func viewDidLoad() {
        
        RequestService.shared.delegate = self
        RequestService.shared.getGenres()
        
        self.moviesIds = try? CoreDataService.shared.fetchAllFavorite()
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
}

extension FavoriteViewController: UITableViewDelegate {
    
}

//extension FavoriteViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.movies.count
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // I'm sure it's castable
//        // swiftlint:disable force_cast
////        let cell = self.tableView
////            .dequeueReusableCell(withIdentifier: "cell",
////                                 for: indexPath) as! FavoriteViewCell
//        // swiftlint:enable foce_cast
//
////        cell.movie = self.movies[indexPath.row]
////
////        return cell
//    }
    
    
//}

extension FavoriteViewController: RequestServiceDelegate {
    func didReceiveData(_ movies: [Movie]) {
    }
    
    func didReceiveGenres(_ genres: [Int : String]) {
        self.genres = genres
    }
    
    func didReceiveMovie(_ movie: Movie) {
        self.allMovies.append(movie)
        self.movies = self.allMovies
//        self.tableView.reloadData()
    }
    
    
}
