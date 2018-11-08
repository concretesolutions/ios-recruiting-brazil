//
//  MoviesViewModel.swift
//  Wonder
//
//  Created by Marcelo on 07/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

class MoviesViewModel {
    
    public var movies : [MovieViewModel] = [MovieViewModel]()
    private var webService = WebService()
    
    init(page: Int, completion: @escaping () -> ()) {

        webService.getPopularMovies(page: page) { (moviesResults) in
             
            if moviesResults.results.count > 0 {

                for theMovie in moviesResults.results {
                    let movie = MovieViewModel(results: theMovie)
                    self.movies.append(movie)
                }
                
                DispatchQueue.main.async {
                    completion()
                }
                
            }
        }
        
        
        
        
//        webService.getNewsSources { (webContent) in
//            // completion
//            if webContent.status == "ok" && webContent.sources.count > 0 {
//                self.sources = webContent.sources.map(SourceViewModel.init)
//            }
//            DispatchQueue.main.async {
//                completion()
//            }
//        }
        
    }
    
    
    
}
