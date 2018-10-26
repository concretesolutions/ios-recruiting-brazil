//
//  MovieDetailsViewController.swift
//  Challenge
//
//  Created by Sávio Berdine on 22/10/18.
//  Copyright © 2018 Sávio Berdine. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var image: UIImage?
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.movie?.name != nil {
            self.name.text = self.movie?.name
        }
        if self.movie?.genre.read() != nil {
            self.genre.text = self.movie?.genre.read()
        }
        if self.movie?.overview != nil {
            self.overview.text = self.movie?.overview
        }
        if self.image != nil {
            self.imageView.image = self.image
        } else {
            self.imageView.kf.indicatorType = .activity
            self.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280/\(String(describing: self.movie?.imagePath!))"))
        }
        if self.movie?.date != nil && self.movie?.date != ""{
            self.year.text = self.movie?.date?.dateYyyyMmDdToDdMmYyyyWithDashes()
        }
        if self.movie?.isFavourite == true {
            self.favoriteButton.setImage(UIImage(named: "Mask Group 4"), for: [])
        } else {
            self.favoriteButton.setImage(UIImage(named: "starBlack"), for: [])
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func favorite(_ sender: Any) {
        if let control = self.movie?.isFavourite {
            let indicator:UIActivityIndicatorView = UIActivityIndicatorView  (style: UIActivityIndicatorView.Style.gray)
            indicator.color = UIColor .black
            indicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
            indicator.center = (self.favoriteButton.imageView?.center)!
            self.favoriteButton.imageView?.addSubview(indicator)
            indicator.bringSubviewToFront(self.favoriteButton.imageView!)
            indicator.startAnimating()
            if control {
                Movie.setFavorite(movie: self.movie!, setAsFavorite: false, onSuccess: { (_) in
                    self.movie?.isFavourite = false
                    Movie.deleteMovieFromCoreData(movie: self.movie!)
                    indicator.stopAnimating()
                    indicator.removeFromSuperview()
                    self.favoriteButton.setImage(UIImage(named: "starBlack"), for: [])
                }) { (error) in
                    indicator.stopAnimating()
                    indicator.removeFromSuperview()
                    print(error)
                }
            } else {
                Movie.setFavorite(movie: self.movie!, setAsFavorite: true, onSuccess: { (_) in
                    self.movie?.isFavourite = true
                    Movie.appendMoviesToCoreData(movies: [self.movie!])
                    indicator.stopAnimating()
                    indicator.removeFromSuperview()
                    self.favoriteButton.setImage(UIImage(named: "Mask Group 4"), for: [])
                }) { (error) in
                    indicator.stopAnimating()
                    indicator.removeFromSuperview()
                    print(error)
                }
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
