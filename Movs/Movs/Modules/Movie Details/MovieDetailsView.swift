//
//  MovieDetailsView.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 14/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class MovieDetailsView: UIViewController {
    
    // MARK: - VIPER
    var presenter: MovieDetailsPresenter!
    
    var favorite: Bool = false {
        didSet {
            self.updateFavoriteIcon(status: favorite)
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var outletActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var outletMovieImage: UIImageView!
    @IBOutlet weak var outletMovieTitle: UILabel!
    @IBOutlet weak var outletFavorite: UIButton!
    @IBOutlet weak var outletMovieGenre: UILabel!
    @IBOutlet weak var outletMovieYear: UILabel!
    @IBOutlet weak var outletMovieOverview: UITextView!
    // MARK: - Outlets Views
    @IBOutlet weak var outletMoviesLoading: MoviesViewLoading!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.presenter.loadMovie()
        
        // Setup Loading View
        self.outletMoviesLoading.isHidden = false
    }
    
    // MARK: - FROM PRESENTER
    
    func setMovie(title: String, favorite: Bool, genre: String, year: String, overview: String, imageURL: String) {
        let imageURL = ServerURL.imageOriginal + imageURL
        self.outletMovieImage.loadImage(imageURL: imageURL) { (movieImage) in
            if let image = movieImage {
                self.setBackground(image: image)
                self.outletMovieImage.image = image
                self.outletActivityIndicator.stopAnimating()
            }
        }
        self.outletMovieTitle.text = title
        self.favorite = favorite
        self.outletMovieGenre.text = genre
        self.outletMovieYear.text = year
        self.outletMovieOverview.text = overview
        
        self.outletMoviesLoading.isHidden = true
    }
    
    // MARK: - Functions
    
    func setBackground(image: UIImage)  {
        let backgroundImage = UIImageView(frame: self.outletMoviesLoading.bounds) //(frame: UIScreen.main.bounds)
        backgroundImage.alpha = 0.05
        backgroundImage.image = image
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func updateFavoriteIcon(status: Bool) {
        if status {
            let imageFull = UIImage.init(named: "favorite_full_icon")
            self.outletFavorite.setBackgroundImage(imageFull, for: .normal)
        }else{
            let imageGray = UIImage.init(named: "favorite_gray_icon")
            self.outletFavorite.setBackgroundImage(imageGray, for: .normal)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func actionFavorite(_ sender: UIButton) {
        if self.favorite {
            self.favorite = false
            self.presenter.removeFavorite()
        }else{
            self.favorite = true
            self.presenter.favorite()
        }
    }
    
    
}

