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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func favorite(_ sender: Any) {
        if let control = self.movie?.isFavourite {
            if control {
                Movie.setFavorite(movie: self.movie!, setAsFavorite: false, onSuccess: { (_) in
                    self.movie?.isFavourite = false
                }) { (error) in
                    print(error)
                }
            } else {
                Movie.setFavorite(movie: self.movie!, setAsFavorite: true, onSuccess: { (_) in
                    self.movie?.isFavourite = true
                }) { (error) in
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
