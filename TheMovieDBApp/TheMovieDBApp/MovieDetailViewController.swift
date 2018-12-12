//
//  MovieDetailController.swift
//  TheMovieDB
//
//  Created by Gustavo Quenca on 03/11/18.
//  Copyright © 2018 Quenca. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    var downloadTask: URLSessionDownloadTask?
    
    private let dataSource = DataSource()
    
    var movieList: MovieListResult!
    
    var selectedMovie: MovieListResult? {
        didSet {
            if isViewLoaded {
                updateUI()
            }
        }
    }
    
    enum FavoriteState {
        case favorite
        case notFavorite
    }

    var favMovie: [MovieListResult?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedMovie != nil {
            updateUI()
        }
        
    UINavigationBar.appearance().barTintColor = UIColor(red: 203/255.0, green: 175/255.0, blue: 93/255.0, alpha: 1.0)
    }
    

    
    func updateUI() {
        titleLabel.text = selectedMovie?.title!
        yearLabel.text = selectedMovie?.release_date!
        
        dataSource.getGenreRequest(completion: { success in
            if !success {
                print("error")
            }
          if case .genreResults(let list) = self.dataSource.genreState {
            for i in 0..<list.count {
                if (self.selectedMovie!.genre_ids?.contains(list[i].id!))! {
                    self.genreLabel.text = list[i].name
                   // print(list[i].name)
                }
            }
            }
        })
        
        
        overviewLabel.text = selectedMovie?.overview!
        if let posterPath = selectedMovie?.poster_path {
            let urlImage = "https://image.tmdb.org/t/p/w200\(posterPath)"
            print(urlImage)
            posterImage.image = UIImage(named: urlImage)
            if let smallURL = URL(string: urlImage) {
                downloadTask = posterImage.loadImage(url: smallURL)
                print("Poster is \(smallURL)")
            }
        }
    }
}




