//
//  FilterFavoritesViewController.swift
//  Movs
//
//  Created by Maisa on 31/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

protocol FilterFavoritesDelegate {
    func moviesFiltered(movies: [FavoriteMoviesModel.FavoriteMovie])
}

class FilterFavoritesViewController: UIViewController {

    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var genreTableTile: UITableView!

    var viewController: FilterFavoritesDelegate?
    
    // Data storage
    var favorites: [MovieDetailed]?
    var years = [String]()
    var genres = [String]()
    // Variables for user actions
    var currentlyYear: String!
    var currentlyGenres: [String]!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        yearPicker.delegate = self
        yearPicker.dataSource = self
        genreTableTile.delegate = self
        genreTableTile.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favorites = FavoriteMoviesWorker.shared.getFavoriteMovies()
        years = getYearList()
        genres = getGenreList()
        // Refreshing data
        if !years.isEmpty && !genres.isEmpty {
            currentlyYear = years[0]
            currentlyGenres = [""]
        }
        yearPicker.reloadAllComponents()
        genreTableTile.reloadData()
    }
    
    // MARK: - Setup

    // Get the years of all movies
    func getYearList() -> [String] {
        guard let movies = favorites else { return [] }
        var years = Set<String>()
        // Get the year of the movie based on the the release date
        let yearOfMovies = movies.map{ String.getYearRelease(fullDate: $0.releaseDate) }
        for year in yearOfMovies {
            years.insert(year) // adding on a set to get only the unique values
        }
        // ordering from the most recent year to the older
        return years.sorted(by: >)
    }
    
    // Get the list of genres for the Favorite Movies
    func getGenreList() -> [String] {
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
    
    // MARK: - Action
    @IBAction func filterFavorites(_ sender: Any) {
        let rawMovies: [MovieDetailed] = FavoriteMoviesWorker.shared.filterMoviesWith(year: currentlyYear, genresNames: currentlyGenres)
        let filteredMovies: [FavoriteMoviesModel.FavoriteMovie] = getFavoritesFormatted(movies: rawMovies)
        viewController?.moviesFiltered(movies: filteredMovies)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /// Formats the presentation of favorite movies to be of type FavoriteMovie
    func getFavoritesFormatted(movies: [MovieDetailed]) -> [FavoriteMoviesModel.FavoriteMovie] {
        var formattedMovies = [FavoriteMoviesModel.FavoriteMovie]()
        for element in movies {
            let formattedMovie = FavoriteMoviesModel.FavoriteMovie.init(id: element.id, title: element.title, overview: element.overview, posterPath: URL(string: element.posterPath)!, year: currentlyYear)
            formattedMovies.append(formattedMovie)
        }
        return formattedMovies
    }
    
}


