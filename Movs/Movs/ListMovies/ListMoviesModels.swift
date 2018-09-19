//
//  ListMoviesModels.swift
//  Movs
//
//  Created by Lucas Ferraço on 15/09/18.
//  Copyright (c) 2018 Lucas Ferraço. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum ListMovies {
	
	enum RequestError: Error {
		case NoConnection, Failure
	}
	
	//MARK:- Get Movies -
	
	struct MovieInfo {
		var id: Int
		var title: String
		var genres: [String]?
		var releaseDate: Date
		var isFavorite: Bool
	}
	
	struct FormattedMovieInfo {
		var id: Int
		var title: String
		var mainGenre: String?
		var release: String
		var isFavorite: Bool
	}
	
	enum GetMovies {
		struct Response {
			let isSuccess: Bool
			let error: RequestError?
			let movies: [MovieInfo]?
		}
		
		struct ViewModel {
			let isSuccess: Bool
			let moviesInfo: [FormattedMovieInfo]?
			let errorMessage: String?
		}
	}
    
    //MARK:- Update Movies -
    
    enum UpdateMovies {
        struct Response {
            let movies: [MovieInfo]
        }
        
        struct ViewModel {
            let moviesInfo: [FormattedMovieInfo]
        }
    }
}
