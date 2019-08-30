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
  
  func getPopularMovies(data: PopularMoviesViewController, collectionView: UICollectionView, page: Int) {
    
    let nextPage = page
    let urlPopularMovies =  API.API_PATH_MOVIES + String(nextPage)
    
    Alamofire.request(urlPopularMovies).validate(statusCode: 200..<299).responseJSON(completionHandler: { response in
      switch response.result {
      case  .success(_):
        let json = response.result.value as! [String : Any]
        guard let movies = Mapper<MoviesData>().map(JSON: json) else { return }
        data.currentPage = movies.page
        data.total_page = movies.total_pages
        data.moviesList.append(contentsOf: movies.results)
        collectionView.reloadData()
      case .failure(let error):
        print(error)
      }
    })
  }
  
  func getGenreMovies() {
    
    let urlGenreMovies = API.API_PATH_GENRE
    
    Alamofire.request(urlGenreMovies).validate(statusCode: 200..<299).responseJSON(completionHandler: { response in
      switch response.result {
      case  .success(_):
        let json = response.result.value as! [String : Any]
        guard let genre = Mapper<GenreData>().map(JSON: json) else { return }
        SessionHelper.saveGenres(genres: genre.genres)
      case .failure(let error):
        print(error)
      }
    })
  }
}


