//
//  FetchMovieDetailOperation.swift
//  Movs
//
//  Created by Gabriel Reynoso on 02/11/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

final class FetchMovieDetailOperation: APIGetOperation {
    
    typealias Result = MovieDetail
    
    let movieId: Int
    
    var apiPath: String {
        return "/movie/\(self.movieId)"
    }
    
    var onSuccess: SuccessCallback?
    var onError: ErrorCallback?
    
    var completeLink:String {
        return "\(self.baseLink)&append_to_response=genres"
    }
    
    init(movieId:Int) {
        self.movieId = movieId
    }
    
    func parse(data:Data) -> MovieDetail? {
        let parser = APIParser<MovieDetail>()
        var result = parser.parse(data: data)
        if let r = result {
            do {
                let favoritesDAO = try FavoriesDAO()
                result?.isFavorite = favoritesDAO.contains(movie: r)
            } catch {}
        }
        return result
    }
}
