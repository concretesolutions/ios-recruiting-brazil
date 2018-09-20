//
//  RequestMovie.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import Foundation
import Alamofire

/// Class responsible for all requests for the movies
class RequestMovie: RequestBase {
    
    /// Requests a list of movies according to the given parameters
    func list(page: Int=1) -> DataRequest{
        parameters["page"] = page
        return get(endpoint: .movies, parameters: parameters)
    }
    
    /// Requests the informations of a given movie
    func detail(of movie:Movie) -> DataRequest{
        return get(endpoint: .detail, movieId: movie.id ?? -1)
    }
    
    /// Requests the genres
    func genres() -> DataRequest{
        return get(endpoint: .genres, parameters: parameters)
    }
    
    /// Requests a list of movies according to the search parameter
    func search(_ term:String?) -> DataRequest{
        parameters["query"] = term
        return get(endpoint: .search, parameters: parameters)
    }
}
