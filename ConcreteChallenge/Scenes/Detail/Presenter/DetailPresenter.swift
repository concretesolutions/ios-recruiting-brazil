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
        .genres,
        .overview(text: movie.overview)
    ]
    
    private var genres: [Genre] = [] {
        didSet {
            var completeGenres: String = ""
            genres.forEach { (genre) in
                completeGenres += genre.name
                if let lastGenre = genres.last, lastGenre.name != genre.name {
                    completeGenres += ", "
                }
            }
            detailView.setGenres(data: GenreViewData(genres: completeGenres))
        }
    }
    
    var numberOfRows: Int {
        return displayData.count
    }
    
    // MARK: - Init -
    init(movie: Movie) {
        self.movie = movie
        super.init()
        getGenres()
    }
    
    // MARK: - Methods -
    private func getGenres() {
        // TODO: Optimize to search locally before
        MovieClient.getGenreList { [weak self] (genreList, error) in
            guard let self = self else { return }
            if let genreList = genreList {
                let matchingGenres = genreList.filter { self.movie.genreIDs.contains($0.id) }
                self.genres = matchingGenres
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
