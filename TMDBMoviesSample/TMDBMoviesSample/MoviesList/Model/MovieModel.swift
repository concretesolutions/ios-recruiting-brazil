//
//  MovieModel.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 04/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class MovieModel: Decodable {
    
    var title: String?
    var releaseDate: String?
    var id: Int?
    var posterPath: String?
    var posterImageData: Data?
    
    enum CodingKeys: String, CodingKey {
        case title
        case releaseDate = "release_date"
        case id
        case posterPath = "poster_path"
    }
}

extension MovieModel {
    func downloadImage(completion: @escaping (ResponseResultType<Data>) -> Void) {
        guard let path = posterPath else { return }
        let client = MoviesListClient()
        client.getMoviePoster(posterPath: path, completion: completion)
    }
}
