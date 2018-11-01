//
//  FilterFavoritesViewController.swift
//  Movs
//
//  Created by Maisa on 31/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

protocol FilterFavoritesDelegate {
    func moviesFiltered() -> [MovieDetailed]
}

class FilterFavoritesViewController: UIViewController {

    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var genreTableTile: UITableView!

    let favoritesWorker = FavoriteMoviesWorker()
    var favorites: [MovieDetailed]?
    var years = [String]()
    var genres = [String]()
    
    var currentlyYear: String = ""
    var currentlyGenres: [String] = [String]()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        yearPicker.delegate = self
        yearPicker.dataSource = self
        genreTableTile.delegate = self
        genreTableTile.dataSource = self
        favorites = favoritesWorker.getFavoriteMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        years = getYearList()
        genres = getGenreList()
        currentlyYear = years[0]
    }
    
    // MARK: - Action
    @IBAction func filterFavorites(_ sender: Any) {
        
    }
    
    // MARK: - Setup
    private func getYearList() -> [String] {
        guard let movies = favorites else { return [] }
        // Get the year of the movie based on the the release date
        return movies.map{ String.getYearRelease(fullDate: $0.releaseDate) }
    }
    
    private func getGenreList() -> [String] {
        guard let movies = favorites else { return [] }
        var genres = Set<String>()
        for movie in movies {
            for genreName in movie.genresNames {
                genres.insert(genreName)
            }
        }
        // Ordering in alphabetic order
        return genres.sorted(by: <)
    }

}


