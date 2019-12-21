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

class DefaultMovieViewModel: MovieViewModel {
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
    
    private let imageRepository: MovieImageRepository
    private let movie: Movie
    private var movieImage: UIImage?
    private var imageTaskCancelCompletion: CancellCompletion?
    
    init(movie: Movie, imageRepository: MovieImageRepository) {
        self.movie = movie
        self.imageRepository = imageRepository
        
        getImage()
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
    
    func movieViewWasReused() {
        self.imageTaskCancelCompletion?()
        self.imageTaskCancelCompletion = nil
        
        self.needReplaceImage?(Constants.placeholderImage)
    }
}

private struct Constants {
    static let placeholderImage = UIImage(named: "placeholderImage")!
}

