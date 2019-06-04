//
//  MovieDetailViewController.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import UIKit
import Cosmos
import Lottie

class MovieDetailViewController: UIViewController {
    
    // MARK: OUTLETS
    @IBOutlet weak var imagePoster: UIImageView!
    
    @IBOutlet weak var imageSmall: UIImageView!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelNameMovie: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var textFieldDescription: UITextView!
    @IBOutlet weak var viewFavorite: AnimationView!
    
    // MARK: CONSTANTS
    
    // MARK: VARIABLES
    private var presenter: MovieDetailPresenter!
    private lazy var viewData:MovieDetailViewData = MovieDetailViewData()
    
    // MARK: IBACTIONS
}

//MARK: - LIFE CYCLE -
extension MovieDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MovieDetailPresenter(viewDelegate: self)
        self.addGesture()
        self.viewFavorite.stop()
    }
}

//MARK: - DELEGATE PRESENTER -
extension MovieDetailViewController: MovieDetailViewDelegate {

}

//MARK: - AUX METHODS -
extension MovieDetailViewController {
    private func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.addAndRemoveFavorite))
        self.viewFavorite.addGestureRecognizer(tap)
    }
    
    @objc private func addAndRemoveFavorite() {
        let animation = Animation.named("favourite_app_icon")
        viewFavorite.animation = animation
        self.viewFavorite.play()
    }
}
