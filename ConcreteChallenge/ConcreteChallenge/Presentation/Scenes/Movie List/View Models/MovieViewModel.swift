//
//  MovieViewModel.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import GenericNetwork

protocol MovieViewModel: AnyObject {
    var movieAtributtes: (title: String, description: String, release: String) { get }
    var needReplaceImage: ((_ image: UIImage) -> Void)? { get set }
    var needReplaceGenres: ((_ genres: String) -> Void)? { get set }
    
    func movieViewWasReused()
}

typealias ImageRouter = (_ imagePath: String) -> Route

class DefaultMovieViewModel: MovieViewModel {
    var movieAtributtes: (title: String, description: String, release: String) {
        return (movie.title ?? "No Title.", movie.overview ?? "No Title.", movie.releaseDate ?? "No Release Date.")
    }
    
    var needReplaceImage: ((_ image: UIImage) -> Void)? {
        didSet {
            guard let movieImage = self.movieImage else {
                return
            }
            
            self.needReplaceImage?(movieImage)
        }
    }
    
    var needReplaceGenres: ((_ genres: String) -> Void)? {
        didSet {
            guard let movieGenres = movieGenres else {
                return
            }
            self.needReplaceGenres?(movieGenres)
        }
    }
    
    private let imageRepository: MovieImageRepository
    private let genresRepository: GenresRepository
    private let movie: Movie
    private var movieImage: UIImage?
    private var imageTaskCancelCompletion: CancellCompletion?
    private var movieGenres: String? {
        didSet {
            guard let movieGenres = movieGenres else {
                return
            }
            self.needReplaceGenres?(movieGenres)
        }
    }
    
    init(movie: Movie, imageRepository: MovieImageRepository, genresRepository: GenresRepository) {
        self.movie = movie
        self.imageRepository = imageRepository
        self.genresRepository = genresRepository
        
        getImage()
        getGenres()
    }
    
    private func getImage() {
        guard let posterPath = movie.posterPath else {
            self.needReplaceImage?(Constants.placeholderImage)
            return
        }
        
        self.imageTaskCancelCompletion = self.imageRepository.getImage(withPath: posterPath) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let imageLocalURL):
                let movieImage = (try? UIImage(url: imageLocalURL)) ?? Constants.placeholderImage
                self.needReplaceImage?(movieImage)
                self.movieImage = movieImage
            case .failure:
                self.needReplaceImage?(Constants.placeholderImage)
            }
        }
    }
    
    private func getGenres() {
        self.genresRepository.getAllGenres { [weak self] (result) in
            guard let self = self else { return }
            switch result {
                
            case .success(let genres):
                self.movieGenres = DefaultMovieViewModel.mapGenres(genres, toMovie: self.movie)
            case .failure:
                self.needReplaceGenres?("")
            }
        }
    }
    
    private static func mapGenres(_ genres: [Genre], toMovie movie: Movie) -> String {
        return genres.reduce("") { (allGenres, genre) -> String in
            guard let genreID = genre.id,
                  let genreName = genre.name,
                  movie.genreIDs.contains(genreID) else {
                return allGenres
            }
            
            return "\(allGenres) \(genreName)"
        }
    }
    
    func movieViewWasReused() {
        self.imageTaskCancelCompletion?()
        self.imageTaskCancelCompletion = nil
        
        self.needReplaceImage?(Constants.placeholderImage)
    }
}

private struct Constants {
    static let placeholderImage = UIImage(named: "placeholderImage")!
}

