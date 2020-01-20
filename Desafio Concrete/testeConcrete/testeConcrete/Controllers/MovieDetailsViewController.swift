//
//  MovieDetails.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 19/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var isFavorite = true
    var movie:Movie?
    var image:UIImage?
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var movieGenre: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetails()
        loadFavorite()
        loadGenres()
    }
    
    func loadGenres(){
        
        CategoryService.getCategory(){
            response in
            DispatchQueue.main.async {
                self.movieGenre.text = response.success?.filter({category in return (self.movie?.genre_ids?.contains(category.id))!}).map({element in return element.name}).joined(separator: "-")
            }
        }
    }
    
    func loadFavorite(){
        if(isFavorite){
            favoriteButton.image = UIImage(named: "favorite_empty_icon")
        }else{
            favoriteButton.image = UIImage(named: "favorite_full_icon")
        }
    }
    
    @IBAction func favoriteAction(_ sender: UIBarButtonItem) {
        self.isFavorite = !self.isFavorite
        loadFavorite()
    }
    
    func loadDetails(){
        self.title = movie?.title
        detailLabel.text = movie?.overview
        imageview.image = self.image
    }
    
}
