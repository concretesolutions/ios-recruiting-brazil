//
//  MovieDetailViewController.swift
//  movs
//
//  Created by Renan Oliveira on 17/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    static let identifier = "MovieDetailViewControllerID"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var movie: MovieData!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.favoriteButton.isSelected = DBManager.sharedInstance.moveIsFavored(movieId: self.movie.id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func loadData() {
        self.movieImageView.sd_setImage(with: movie.posterPath.toImageUrl(), completed: nil)
        self.titleLabel.text = self.movie.originalTitle
        self.releaseDateLabel.text = DateUtil.convertDateStringToString(dateString: self.movie.releaseData, formatter: "yyyy-MM-dd", toFormatter: "yyyy")
        self.genreLabel.text = self.movie.genres.map {
            return $0.name
        }.joined(separator: ", ")
        self.overview.text = self.movie.overview
        self.favoriteButton.isSelected = DBManager.sharedInstance.moveIsFavored(movieId: self.movie.id)
    }
    
    // IBAction
    @IBAction func favoriteTap() {
        self.favoriteButton.isSelected = !self.favoriteButton.isSelected
        if DBManager.sharedInstance.moveIsFavored(movieId: self.movie.id) {
            DBManager.sharedInstance.deleteMovie(movieId: self.movie.id)
        } else {
            DBManager.sharedInstance.addData(object: DBManager.sharedInstance.createObject(model: self.movie))
        }
    }
}
