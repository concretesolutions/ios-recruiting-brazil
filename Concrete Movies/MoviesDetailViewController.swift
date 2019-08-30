//
//  MoviesDetailViewController.swift
//  Concrete Movies
//
//  Created by Lucas Daniel on 25/08/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import UIKit

class MoviesDetailViewController: UIViewController {

    var movieID: Int = 0
    
    var moviesService = MoviesService()
    
    var handleMovie = HandleMovie()
    
    var moviesDetail: MoviesDetail?
    
    var stack = CoreDataStack.shared
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieType: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    
    @IBOutlet weak var favoriteButton: NSLayoutConstraint!
    @IBOutlet weak var favoriteButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var favoriteButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var favoriteButtonBottom: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesService.getMoviesDetail(movieID: movieID) { result in
            if result != nil {
                self.moviesDetail = result
                self.movieName.text = result?.title!
                self.movieYear.text = result?.release_date!.take(4)
                self.movieType.text = result?.genres?[0].name!
                self.movieDescription.text = result?.overview!
                
                let url = URL(string: "https://image.tmdb.org/t/p/w500" + (result?.poster_path)!)
                self.movieImage.kf.setImage(with: url)
                
                self.favoriteButtonHeight.constant = Screen.screenHeight*10/100
                self.favoriteButtonWidth.constant = Screen.screenHeight*10/100
                self.favoriteButtonBottom.constant = Screen.screenHeight*5/100
            }
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func favorite(_ sender: UIButton) {
        print(self.moviesDetail?.overview)
        self.handleMovie.saveMovie(id:  "\(self.moviesDetail?.id!)" ?? "",
                                   overview: (self.moviesDetail?.overview!)!, poster_path: (self.moviesDetail?.poster_path!)!, release_date: (self.moviesDetail?.release_date!)!, title: (self.moviesDetail?.title!)!, context: self.stack.viewContext) { result in
            if result {
                print(result)
            } else {
                print(result)
            }
                                    
            print(result)
                                    
        }
    }
    
    
    
}
