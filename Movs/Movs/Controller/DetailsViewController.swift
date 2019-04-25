//
//  DetailsViewController.swift
//  Movs
//
//  Created by Ygor Nascimento on 24/04/19.
//  Copyright © 2019 Ygor Nascimento. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    //Outlets
    @IBOutlet weak var movieDetailImage: UIImageView!
    @IBOutlet weak var movieDetailTitlelabel: UILabel!
    @IBOutlet weak var movieDetailYearLabel: UILabel!
    @IBOutlet weak var movieDetailGenreLabel: UILabel!
    @IBOutlet weak var movieDetailTextView: UITextView!
    
    
    //Variables
    var selectedMovie: Movie!
    let tmdbBaseBackdropImageURL = "https://image.tmdb.org/t/p/w780"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backdropImageURL = URL(string: tmdbBaseBackdropImageURL+selectedMovie.backdrop_path)!
        let imageData = try? Data(contentsOf: backdropImageURL)
        
        movieDetailImage.image = UIImage(data: imageData!)
        movieDetailTitlelabel.text = "Title:  \(selectedMovie.title)"
        movieDetailYearLabel.text = "Release Date:  \(selectedMovie.release_date)"
        genres()
        movieDetailGenreLabel.text = "Genre:  ..."
        movieDetailTextView.textContainer.lineFragmentPadding = 0
        movieDetailTextView.text = "Overview:  \(selectedMovie.overview)"
    }
    
    func genres() {
        for genre in selectedMovie.genre_ids {
            print(genre)
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
