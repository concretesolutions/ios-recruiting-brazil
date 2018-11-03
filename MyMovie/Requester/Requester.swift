//
//  Singleton.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 23/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//

import UIKit


class Requester: NSObject {
	static var arrayMovies:[Movie] = Singleton.sharedInstance.movies
	static var arrayGenres:[Genre] = Singleton.sharedInstance.genres
	
	static func getMovies(page: Int, qtdeMovies:Int,completionHandler completion:@escaping (_ success:Bool, _ error : NSError?) -> Void){
		
		MovieDAO.get(endpoint: .mostPopular(page: page)) { (response, errorResponse) in
			
			if let responseData = response {
				do {
					let popularMoviesResponse = try JSONDecoder().decode(PopularMovieResponse.self, from: responseData)
					
					guard let movies = popularMoviesResponse.results else {
						completion(false, nil)
						return
					}
					
					for movie in movies {
						self.arrayMovies.append(movie)
					}
					
					Singleton.sharedInstance.movies = self.arrayMovies
					completion(true, nil)
				} catch {
					print(error.localizedDescription)
					completion(false, nil)
					
				}
			} else if let error = errorResponse {
				print(error.localizedDescription)
				completion(false, nil)
			}
		}
	}
	
	static func getGenre(completionHandler completion:@escaping (_ success:Bool, _ error : NSError?) -> Void){
		MovieDAO.get(endpoint: .genres()) { (response, errorResponse) in
			if let responseData = response {
				do {
					let genreList = try JSONDecoder().decode(GenreResponse.self, from: responseData)
					
					guard let genres = genreList.genres else {
						completion(false, nil)
						return
					}
					
					for genre in genres {
						self.arrayGenres.append(genre)
					}
					
					Singleton.sharedInstance.genres = self.arrayGenres
					completion(true, nil)
				} catch {
					print(error.localizedDescription)
					completion(false, nil)
				}
			} else if let error = errorResponse {
				print(error.localizedDescription)
				completion(false, nil)
			}
		}
	}
}
