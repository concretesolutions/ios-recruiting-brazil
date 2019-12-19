//
//  MovieDetailsViewModel.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 17/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit
import CoreData

class MovieDetailsViewModel: NSObject {

    private let provider = URLSessionProvider()

    private(set) var id: Int
    private(set) var posterImage: UIImage
    private(set) var title: String
    private(set) var genreNames: [String]
    private(set) var isFavorited: Bool
    private(set) var overview: String
    private let genreIDs: [Int]

    init(id: Int, title: String, overview: String, posterImage: UIImage, genreIDs: [Int]) {
        self.id = id
        self.title = title
        self.posterImage = posterImage
        self.genreIDs = genreIDs
        self.genreNames = []
        self.isFavorited = false
        self.overview = overview
        super.init()
        fetchGenres()
        checkIsFavorited()
    }

    convenience init(movie: Movie) {
        self.init(
            id: movie.id,
            title: movie.title,
            overview: movie.overview,
            posterImage: movie.posterImage ?? UIImage(),
            genreIDs: movie.genreIDs
        )
    }

    convenience init(favoritedMovie: FavoriteMovie) {
        self.init(
            id: Int(favoritedMovie.id),
            title: favoritedMovie.title ?? "",
            overview: favoritedMovie.overview ?? "",
            posterImage: UIImage(data: favoritedMovie.posterImage!) ?? UIImage(),
            genreIDs: favoritedMovie.genreIDs?.map({ $0.intValue }) ?? []
        )
    }

    private func fetchGenres() {
        let provider = URLSessionProvider()
        provider.request(type: GenreListRoot.self, service: MovieDBService.movieGenres) { result in
            switch result {
            case .success(let data):
                self.handleFetched(data.genres)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func handleFetched(_ genres: [Genre]) {
        let filtered = genres.filter({ self.genreIDs.contains($0.id) })
        genreNames.append(contentsOf: filtered.map({ $0.name }))
    }

    private func firstFavorite(with id: Int) -> FavoriteMovie? {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)

        return CoreDataStore.findFirst(fetchRequest)
    }

    private func checkIsFavorited() {
        if firstFavorite(with: id) != nil {
            isFavorited = true
        }
    }

    private func favoriteMovie() {
        let newFavorite = FavoriteMovie(context: CoreDataStore.context)
        newFavorite.title = title
        newFavorite.id = Int64(id)
        newFavorite.overview = overview
        newFavorite.posterImage = posterImage.jpegData(compressionQuality: 1.0)
        newFavorite.genreIDs = genreIDs.map({ NSNumber(value: $0) })

        CoreDataStore.saveContext()
        isFavorited = true
    }

    private func removeFavorite() {
        if let wantedFavorite = firstFavorite(with: id) {
            CoreDataStore.delete(wantedFavorite)
            isFavorited = false
        }
    }

    func favoriteButtonHandler(completion: (Bool) -> Void) {
        if !isFavorited {
            favoriteMovie()
        } else {
            removeFavorite()
        }

        completion(isFavorited)
    }
}
