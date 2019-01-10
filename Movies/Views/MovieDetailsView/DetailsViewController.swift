//
//  DetailsViewController.swift
//  Movies
//
//  Created by Matheus Queiroz on 1/10/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var posterImageViewController: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieGenresLabel: UILabel!
    @IBOutlet weak var moviePopularityLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    var selectedMovie: MovieModel?
    var model: DetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        model = DetailsViewModel(viewController: self)
        
        self.navigationItem.title = "\(selectedMovie!.title)"
        
        posterImageViewController.image = selectedMovie?.thumbnail
        movieNameLabel.text = selectedMovie?.title
        movieYearLabel.text = "\(selectedMovie!.releaseYear.year!)"
        movieGenresLabel.text = "Haha"
        moviePopularityLabel.text = "Popularity: \(selectedMovie!.popularity)"
        movieDescriptionLabel.text = selectedMovie?.overview
        movieDescriptionLabel.sizeToFit()
        
        model?.getGenres(forMovie: selectedMovie!)
        
        var genresString = NSMutableString()
        selectedMovie?.genresStringArray.forEach { genre in
            genresString.append("\(genre), ")
        }
//        genresString.deleteCharacters(in: NSRange(location: genresString.length - 3, length: genresString.length-1) )
        let genreToDisplay = genresString.substring(to: genresString.length-2)
        movieGenresLabel.text = genreToDisplay as String
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
