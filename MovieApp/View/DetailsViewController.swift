//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by Mac Pro on 29/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {

    var movie: Movie?
    
    @IBOutlet weak var detailTopoIv: UIImageView!
    @IBOutlet weak var titleDetails: UILabel!
    @IBOutlet weak var yearDetailLb: UILabel!
    @IBOutlet weak var typeDetailLb: UILabel!
    @IBOutlet weak var descDetailLb: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setMovieDetails()
        
    }
    
    func setMovieDetails(){
        
        guard let movie = self.movie else {return}
        detailTopoIv.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdropPath!)"), completed: nil)
        titleDetails.text = movie.title
        yearDetailLb.text = movie.releaseDate
        typeDetailLb.text = ""
        descDetailLb.text = movie.overview
        
    }

}
