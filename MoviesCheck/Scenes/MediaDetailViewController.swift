//
//  MediaDetailViewController.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 03/11/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

class MediaDetailViewController: UIViewController {

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var descriptionTextView: UITextView!
    
    var mediaItem:MediaItem? = nil
    var currentMediaGenres:Array<Int> = Array()
    var isCurrentMediaFavorited = false
    
    //Webservice loader
    let jsonLoader = JsonLoader()
    
    //Type for the search of the current ViewController hierarchy
    var searchType:ScreenType? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonLoader.genresDelegate = self
        setupMediaInformation()
        
    }
    
    func setupMediaInformation(){
        
        if let media = mediaItem{
            
            //ViewController Title
            title = media.title
            
            //Screen elements
            posterImageView.loadImage(fromURL: media.getPosterURL())
            
            titleLabel.text = media.title
            
            let ratingPercentage = media.evaluation * 100 / 10
            //ratingLabel.text = "Rating: \(ratingPercentage)%"
            ratingLabel.text = String(format: "Rating: %.0f%%", ratingPercentage)
            
            genresLabel.text = "";
            currentMediaGenres = media.genres
            
            descriptionTextView.text = media.overview
            
            //Config favorite buttom
            if(DatabaseWorker.shared.isFavorited(media: media)){
                isCurrentMediaFavorited = true
                favoriteButton.setImage(UIImage(named: "favorited"), for: UIControl.State.normal)
                favoriteButton.setTitle("Remove from favorites", for: UIControl.State.normal)
            }else{
                isCurrentMediaFavorited = false
                favoriteButton.setImage(UIImage(named: "unfavorited"), for: UIControl.State.normal)
                favoriteButton.setTitle("Add to favorites", for: UIControl.State.normal)
            }
            
        }
        
        //Load genres information
        if let type = searchType{
            jsonLoader.loadGenres(type: type)
        }
        
    }
    
    
    @IBAction func toggleFavorite(_ sender: Any) {
        
        if(isCurrentMediaFavorited){
            unfavorite()
        }else{
            favorite()
        }
        
    }
    
    func favorite(){
        isCurrentMediaFavorited = true
        
        if let media = mediaItem{
            DatabaseWorker.shared.addMediaToFavorites(media: media)
        }
        
        DispatchQueue.main.async {
            self.favoriteButton.setImage(UIImage(named: "favorited"), for: UIControl.State.normal)
            self.favoriteButton.setTitle("Remove from favorites", for: UIControl.State.normal)
        }
        
    }
    
    func unfavorite(){
        isCurrentMediaFavorited = false
        
        if let media = mediaItem{
            DatabaseWorker.shared.removeMediaFromFavorites(media: media)
        }
        
        DispatchQueue.main.async {
            self.favoriteButton.setImage(UIImage(named: "unfavorited"), for: UIControl.State.normal)
            self.favoriteButton.setTitle("Add to favorites", for: UIControl.State.normal)
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

//MARK:- JsonLoaderDelegate
extension MediaDetailViewController:JsonLoaderGenresDelegate{
    func genresLoaded(genres: GenreResult) {
        
        DispatchQueue.main.async {
            self.genresLabel.text = GenresWorker.getGenresDescription(validGenres: self.currentMediaGenres, genresList: genres)
        }
        
    }
    
    
}
