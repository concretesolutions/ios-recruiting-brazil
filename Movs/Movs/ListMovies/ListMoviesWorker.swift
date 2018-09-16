//
//  ListMoviesWorker.swift
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

class ListMoviesWorker {
	
	private var moviesTMDbWorker: MoviesTMDbWorker?
	
	// MARK:- Pagination helpers
	private var currentPage: Int = 1
	private var totalPages: Int = 0
	
	//MARK:- Public Methods
	
	/// Downloads a list of the most popular movies.
	///
	/// - Parameter completion: The handler to be called once the movies were downloaded.
	/// - Parameter success: Whether or not the method suceeded.
	/// - Parameter response: The decoded response for the call.
	/// - Parameter error: The error encontered during the download.
	public func downloadPopularMovies<T>(_ completion: @escaping (_ success: Bool, _ response: [T]?, _ error: ListMovies.RequestError?) -> Void) where T : Decodable {
		
		// Resets pagination
		currentPage = 1
		totalPages = 0
		
		moviesTMDbWorker = MoviesTMDbWorker()
		moviesTMDbWorker?.fetchMoviesList(of: .popular, on: currentPage) { (result) in
			if result.success, let apiResponse = result.response {
				self.totalPages = apiResponse.totalPages
				
				do {
					let response = try self.getGenericMovies(fromAPIMovies: apiResponse.movies, to: T.self)
					self.currentPage += 1
					completion(true, response, nil)
				} catch _ {
					completion(false, nil, .Failure)
				}
			} else {
				let error = self.useCaseError(for: result.error)
				completion(false, nil, error)
			}
		}
	}
	
	//MARK:- Auxiliary methods
	
	private func getGenericMovies<T>(fromAPIMovies apiMovies: [TMDbMovie], to type: T.Type) throws -> [T]  where T : Decodable {
		var genericMovies: [T] = []
		do {
			for m in apiMovies {
				let t = try self.decode(apiMovie: m, to: T.self)
				genericMovies.append(t)
			}
			
			return genericMovies
		} catch _ {
			throw ListMovies.RequestError.Failure
		}
	}
	
	private func decode<T>(apiMovie: TMDbMovie, to type: T.Type) throws -> T where T : Decodable {
		let encoder = JSONEncoder()
		let decoder = JSONDecoder()
		
		do {
			let raw = try encoder.encode(apiMovie)
			let t = try decoder.decode(T.self, from: raw)
			return t
		} catch _ {
			throw ListMovies.RequestError.Failure
		}
	}
	
	private func useCaseError(for apiError: MoviesTMDbWorkerError?) -> ListMovies.RequestError {
		guard let apiError = apiError else {
			return ListMovies.RequestError.Failure
		}
		
		switch apiError {
		case .NoConnection:
			return ListMovies.RequestError.NoConnection
		case .Failure:
			return ListMovies.RequestError.Failure
		}
	}
}
