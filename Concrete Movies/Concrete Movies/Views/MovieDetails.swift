//
//  MovieDetails.swift
//  Concrete Movies
//
//  Created by Henrique Barbosa on 01/08/19.
//  Copyright © 2019 Henrique Barbosa. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class MovieDetails: ViewController {
    @IBOutlet weak var movieDetailsImage: UIImageView!
    @IBOutlet weak var movieDetailsTitle: UILabel!
    @IBOutlet weak var movieDetailsYear: UILabel!
    @IBOutlet weak var movieDetailsGenre: UILabel!
    @IBOutlet weak var movieDetailsOverview: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func dismissMovieDetails(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var movieDetailsInfo: Movie? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        let vc = self.presentingViewController as! TabBarSettings
        let moviesTabVC = vc.children.first as! MoviesTabViewController
        moviesTabVC.movieDetails = self
        favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .selected)
    }
    @IBAction func movieDetailsFavoriteButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            sender.isSelected = !sender.isSelected
        }
        setMovieFavorite()
    }
}

extension MovieDetails: MovieDetailsDelegate {
    
    func sendMovieDetails(_ movie: Movie) {
        movieDetailsImage.image = UIImage(data: movie.image!)
        movieDetailsTitle.text = movie.name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateLabelFormatter = DateFormatter()
        dateLabelFormatter.dateFormat = "dd-MM-yyyy"
        let date: Date = dateFormatter.date(from: movie.date) ?? Date()
        movieDetailsYear.text = dateLabelFormatter.string(from: date)
        movieDetailsOverview.text = movie.details
        var text: String = ""
        movie.genre.forEach { (genre) in
            text.append(genre.name)
            text.append("\n")
        }
        movieDetailsGenre.text = text
        self.movieDetailsInfo = movie
        queryObjects()
    }
}

extension MovieDetails {
    
    func queryObjects() {
        do {
            let realm = try Realm()
            let movies = realm.objects(Movie.self)
            movies.forEach { (movie) in
                if(movie.id == self.movieDetailsInfo?.id && movie.favorite) {
                    DispatchQueue.main.async {
                        self.favoriteButton.isSelected = true
                    }
                }
            }
        } catch {
            print("realm error")
        }
    }
    
    func setMovieFavorite() {
        do {
            let realm = try Realm()
            try realm.write {
            let movieUpdated = self.movieDetailsInfo
            movieUpdated!.favorite = !movieUpdated!.favorite
            realm.add(movieUpdated!, update: .modified)
            }
        } catch  {
            print("realm error")
        }
    }
}
