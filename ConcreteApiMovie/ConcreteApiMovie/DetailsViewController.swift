//
//  DetailsViewController.swift
//  ConcreteApiMovie
//
//  Created by Israel3D on 18/09/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {

    @IBOutlet weak var imaMovieDetail: UIImageView!
    @IBOutlet weak var lblMovieDetail: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    @IBOutlet weak var lblMovieGeners: UILabel!
    @IBOutlet weak var lblMovieOverview: UILabel!
    @IBOutlet weak var btnAddFavorite: UIButton!
    
    
    var movie: MoviesResults!
    var genersArray:[MovieGenresDetails] = []
    var moviesIds: [Int] = []
    var favorited:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showDetailsMovie(idMovie: movie.id)
        moviesIds = FavoritesUserDefaults().showFavoritesMovie()
        favorited = moviesIds.contains(movie.id)
        if (favorited) {
            btnAddFavorite.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
        }
    }
    
    func showDetailsMovie(idMovie:Int) {
        if let url = URL(string: movie.urlImage) {
            imaMovieDetail.kf.indicatorType = .activity
            imaMovieDetail.kf.setImage(with: url)
        } else {
            imaMovieDetail.image = nil
        }
        
        lblMovieDetail.text = movie.title
        lblMovieYear.text = String(movie.release_date.prefix(4))
        lblMovieOverview.text = movie.overview
        
        MoviesAPI.loadMovieGener(idMovie: idMovie) { (gener) in
            if let gener = gener?.genres {
                self.genersArray += gener
                var genersToLabel = ""
                for i in 0...self.genersArray.count-1 {
                    genersToLabel += "," + self.genersArray[i].name
                }
                genersToLabel.remove(at: genersToLabel.startIndex)
                self.lblMovieGeners.text = genersToLabel
            }
        }
        
    }
    
    @IBAction func addFavorite(_ sender: UIButton) {
        if (!favorited) {
            let favoriteUserDefaults = FavoritesUserDefaults()
            favoriteUserDefaults.addFavoriteMovie(movie: movie.id)
            btnAddFavorite.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
        }
    }

}
