//
//  SelectedMovieTableViewController.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 12/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import UIKit
import Kingfisher

class SelectedMovieTableViewController: UITableViewController {
    
    var movie: Movie?
    var genres = [Genre]()
    
    @IBOutlet weak var movieImageOutlet: UIImageView!
    @IBOutlet weak var movieTitleOutlet: UILabel!
    @IBOutlet weak var movieReleaseDateOutlet: UILabel!
    @IBOutlet weak var movieGenreOutlet: UILabel!
    @IBOutlet weak var movieOverviewOutlet: UITextView!
    @IBOutlet weak var isFavoriteButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        //self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieDAO.getGenres { (response, error) in
            if error == nil{
            
                if let genres = response as? Genres{
                    for genre in genres.genres{
                        self.genres.append(genre)
                    }
                }
                
            }else{
                print("Error")
            }
            var genresString: String = ""
            
            for genre in (self.movie?.genre_ids)! {
                
                for genreUnit in self.genres{
                    if genre == genreUnit.id {
                        
                        if genresString == ""{
                            genresString += genreUnit.name
                        }else{
                            genresString += "," + genreUnit.name
                        }
                        
                        
                    }
                }
            }
            
            self.movieGenreOutlet.text = genresString
        }
        
        if MovieDAO.isMovieFavorite(comparedMovie: self.movie!){
            self.isFavoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        }
        
        if let title = self.movie?.title {
            self.movieTitleOutlet.text = title
        }
        
        if let releaseDate = self.movie?.release_date {
            
            var parts = releaseDate.components(separatedBy: "-")
            self.movieReleaseDateOutlet.text = parts[0]
            
        }
        
        
        
        if let overview = self.movie?.overview {
            self.movieOverviewOutlet.text = overview
        }
        
        
        
        let imageUrl = "https://image.tmdb.org/t/p/w500"
        let imageEndpoint = imageUrl + (movie?.poster_path)!
        print(imageEndpoint)
        
        let url = URL(string: imageEndpoint)
        
        self.movieImageOutlet.kf.setImage(with: url)
        
    }
    
    @IBAction func isFavoriteButtonTapped(_ sender: Any) {
        
        if MovieDAO.isMovieFavorite(comparedMovie: self.movie!){
            
            MovieDAO.deleteFavoriteMovie(favoriteMovie: self.movie!)
            self.isFavoriteButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
            
        }else{
            
            MovieDAO.saveMovieAsFavorite(movie: self.movie!)
            self.isFavoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            
        }
        
    }
    

    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
