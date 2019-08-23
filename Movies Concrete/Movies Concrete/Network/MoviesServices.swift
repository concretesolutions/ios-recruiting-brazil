//
//  MoviesServices.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 22/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class MoviesServices: NSObject {
  
  func getPopularMovies(data: MoviesViewController, collectionView: UICollectionView) {
    
    let urlPopularMovies =  API.API_URL + "movie/popular?api_key=" + API.API_KEY
    
    Alamofire.request(urlPopularMovies).validate().responseJSON { response in
      let json = response.result.value as! [String : Any]
      guard let movies = Mapper<MoviesList>().map(JSON: json) else { return }
        data.moviesList.append(contentsOf: movies.results)
        collectionView.reloadData()
      }
    }
}

//if error == nil {
//  completion?(nil, nil, cache)
//} else {
//  completion?(nil, error, cache)
//}


