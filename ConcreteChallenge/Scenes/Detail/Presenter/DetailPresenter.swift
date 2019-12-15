//
//  DetailPresenter.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation
import os.log

final class DetailPresenter: BasePresenter {
    
    // MARK: - Properties -
    /// The movie to display the details
    private let movie: Movie
    
    private var detailView: DetailViewDelegate {
        guard let view = view as? DetailViewDelegate else {
            os_log("❌ - DetailPresenter was given to the wrong view", log: Logger.appLog(), type: .fault)
            fatalError("DetailPresenter was given to the wrong view")
        }
        return view
    }
    
    private lazy var displayData: [DetailInfoType] = [
        .poster(imageURL: ImageEndpoint.image(width: 500, path: movie.posterPath).completeURL),
        .title(movie.title),
        .year(movie.releaseDate),
        .genres(self.genresText),
        .overview(text: movie.overview)
    ]
    
    private var genres: [Genre] = [] {
        didSet {
            detailView.setGenres(data: GenreViewData(genres: self.genresText))
        }
    }
    
    var genresText: String {
        var completeGenres: String = ""
        genres.forEach { (genre) in
            completeGenres += genre.name
            if let lastGenre = genres.last, lastGenre.name != genre.name {
                completeGenres += ", "
            }
        }
        return completeGenres != "" ? completeGenres : "Loading genres..."
    }
    
    var numberOfRows: Int {
        return displayData.count
    }
    
    var isFavorite: Bool {
        return movie.isFavorite
    }
    
    // MARK: - Init -
    init(movie: Movie) {
        self.movie = movie
        super.init()
    }
    
    // MARK: - Methods -
    override func attachView(_ view: ViewDelegate) {
        super.attachView(view)
        getGenres()
    }
    
    private func getGenres() {
        // Searchs locally before
        if let genreList = LocalService.instance.getGenreList(from: movie.genreIDs) {
            self.genres = genreList
        } else {
            // Had one or more genres not locally found.
            // Needs to update the local list.
            MovieClient.getGenreList { [weak self] (genreList, error) in
                guard let self = self else { return }
                if let genreList = genreList {
                    let matchingGenres = genreList.filter { self.movie.genreIDs.contains($0.id) }
                    self.genres = matchingGenres
                }
            }
        }
    }
    
    func getDetailInfo(row: Int) -> DetailInfoType {
        guard row < self.numberOfRows else {
            os_log("❌ - Number of rows > number of info", log: Logger.appLog(), type: .fault)
            // Return anything so as not to just crash
            return .overview(text: "")
        }
        
        return displayData[row]
    }
    
    func getBarTitle() -> String {
        return "Movie"
    }
}

extension DetailPresenter: FavoriteHandler {
    func favoriteStateChanged(tag: Int? = nil) {
        
        movie.isFavorite = !movie.isFavorite
        detailView.setFavorite(movie.isFavorite, tag: nil)
        if movie.isFavorite {
            LocalService.instance.setFavorite(movie: movie)
        } else {
            LocalService.instance.removeFavorite(movie: movie)
        }
    }
}
