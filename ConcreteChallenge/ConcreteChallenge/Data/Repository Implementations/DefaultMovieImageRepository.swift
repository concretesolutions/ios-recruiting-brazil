//
//  DefaultMovieImageRepository.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import GenericNetwork

class DefaultMovieImageRepository<ImageProviderType: FileProvider>: MovieImageRepository {
    
    private let imagesProvider: ImageProviderType
    
    init(imagesProvider: ImageProviderType) {
        self.imagesProvider = imagesProvider
    }
    
    func getImage(withPath path: String, completion: @escaping ((Result<URL, Error>) -> Void)) -> CancellCompletion {
        let cancellable = imagesProvider.request(route: TMDBMoviesRoute.image(path), completion: completion)
        return {
            cancellable?.cancel()
        }
    }
}
