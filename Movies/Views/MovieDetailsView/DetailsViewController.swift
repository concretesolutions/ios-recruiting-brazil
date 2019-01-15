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
    @IBOutlet weak var FavoritesButton: UIButton!
    
    var selectedMovie: MovieModel?
    var model: DetailsViewModel?
    var isFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        model = DetailsViewModel(viewController: self)
        
        self.navigationItem.title = "\(selectedMovie!.title)"
        
        posterImageViewController.image = selectedMovie?.thumbnail
        movieNameLabel.text = selectedMovie?.title
        movieYearLabel.text = "\(selectedMovie!.releaseYear.year!)"
        movieGenresLabel.text = "Loading Genres..."
        moviePopularityLabel.text = "Popularity: \(selectedMovie!.popularity)"
        movieDescriptionLabel.text = selectedMovie?.overview
        movieDescriptionLabel.sizeToFit()
        
        if(selectedMovie?.genresStringSet.count == 0){
            model?.getGenres(forMovie: selectedMovie!)
        }
        let genresString = NSMutableString()
        selectedMovie?.genresStringSet.forEach { genre in
            if (genre != ""){
                genresString.append("\(genre), ")
            }
        }
        
        let genreToDisplay = genresString.substring(to: genresString.length-2)
        movieGenresLabel.text = genreToDisplay as String
        
        isFavorite = model!.verifyIfFavorite(selectedMovie: selectedMovie!)
        if (isFavorite){
            FavoritesButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        } else {
            FavoritesButton.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
        }
    }

    @IBAction func didPressFavoritesButton(_ sender: Any) {
        if (!isFavorite){
            FavoritesButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            model?.addToFavorites(selectedMovie: selectedMovie!)
        } else {
            let deleteMenu = UIAlertController(title: "Remove From Favorites", message: "Are you sure you want to remove \(selectedMovie!.title) from your favorites?", preferredStyle: UIAlertController.Style.actionSheet)
            let removeAction = UIAlertAction(title: "Remove", style: UIAlertAction.Style.destructive, handler: { (action) in
                self.model?.remove(fromFavorites: self.selectedMovie!)
                self.FavoritesButton.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            
            deleteMenu.addAction(removeAction)
            deleteMenu.addAction(cancelAction)
            
            self.present(deleteMenu, animated: true, completion: nil)
        }
    }
}
