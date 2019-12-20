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
    var movieTitle: String? { get }
    var needReplaceImage: ((_ image: UIImage) -> Void)? { get set }
    
    func movieViewWasReused()
}

typealias ImageRouter = (_ imagePath: String) -> Route

class DefaultMovieViewModel<ImageProviderType: FileProvider>: MovieViewModel {
    var movieTitle: (String?) {
        return (movie.title ?? "No Title.")
    }
    
    var needReplaceImage: ((_ image: UIImage) -> Void)? {
        didSet {
            guard let movieImage = self.movieImage else {
                return
            }
            
            self.needReplaceImage?(movieImage)
        }
    }
    
    private let imageProvider: ImageProviderType
    private let movie: Movie
    private var movieImage: UIImage?
    private let imageRouter: ImageRouter
    private var imageTask: CancellableTask?
    
    init(movie: Movie, imageProvider: ImageProviderType, imageRouter: @escaping ImageRouter) {
        self.movie = movie
        self.imageProvider = imageProvider
        self.imageRouter = imageRouter
        
        getImage()
    }
    
    private func getImage() {
        guard let posterPath = movie.posterPath else {
            self.needReplaceImage?(Constants.placeholderImage)
            return
        }
        
        self.imageTask = imageProvider.request(route: imageRouter(posterPath)) { [weak self] (result) in
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
    
    func movieViewWasReused() {
        self.imageTask?.cancel()
        self.imageTask = nil
        
        self.needReplaceImage?(Constants.placeholderImage)
    }
}

private struct Constants {
    static let placeholderImage = UIImage(named: "placeholderImage")!
}

