//
//  ConvertMovieEntityToModelUseCase.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import RxSwift

/// Converte uma MovieEntity em uma instância do tipo Movie
final class ConvertMovieEntityToModelUseCase {
    
    private var genreMemoryRepository: GenreMemoryRepositoryProtocol
    
    init(genreMemoryRepository: GenreMemoryRepositoryProtocol) {
        self.genreMemoryRepository = genreMemoryRepository
    }
    
    func run(movies: [MovieEntity]) -> [Movie] {
        var moviesAux = [Movie]()
        for movieEntity in movies {
            let movie = convert(entity: movieEntity)
            moviesAux.append(movie)
        }
        
        return moviesAux
    }
    
    private func convert(entity: MovieEntity) -> Movie {
        var image: UIImage = UIImage()
        
        let url = URL(string: NetworkConstants.baseImageURL + entity.posterPath)!
        if let data = try? Data(contentsOf: url) {
            image = UIImage(data: data)!
        } else {
            image = UIImage()
        }
        
        var genres = [Genre]()
        
        for genreId in entity.genreIds {
            if let genre = genreMemoryRepository.getGenre(with: genreId) {
                genres.append(genre)
            }
        }
        
        let movie = Movie(id: entity.id,
                          title: entity.title,
                          image: image,
                          releaseDate: entity.releaseDate,
                          overview: entity.overview,
                          genres: genres)
        
        return movie
    }
}
