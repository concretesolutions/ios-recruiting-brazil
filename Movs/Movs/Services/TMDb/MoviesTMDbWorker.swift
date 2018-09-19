//
//  MoviesTMDbWorker.swift
//  Movs
//
//  Created by Lucas Ferraço on 16/09/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import Foundation

enum MoviesTMDbWorkerError: Error {
	case NoConnection
	case Failure
}

class MoviesTMDbWorker: TMDbClient {
	
	private var httpNetworkWorker: HTTPNetworkWorker? = nil
	private var genreWorker: GenreTMDbWorker?
	
	public struct MoviesListResponse: Decodable {
		var movies: [TMDbMovie]
		let page: Int
		let totalPages: Int
		
		private enum CodingKeys: String, CodingKey {
			case movies = "results"
			case page
			case totalPages = "total_pages"
		}
	}
	
	public enum ListType: String {
		case upcoming 		= "/upcoming"
		case topRated 		= "/top_rated"
		case popular		= "/popular"
		case nowPlaying		= "/now_playing"
	}
	
	override init() {
		super.init()
		genreWorker = GenreTMDbWorker()
		genreWorker?.fetchGenres(of: .movie)
	}
	
	//MARK:- Public Methods
	
	typealias FetchMoviesListResponse = (success: Bool, response: MoviesListResponse?, error: MoviesTMDbWorkerError?)
	
	/// Downloads a list of movies' information according to the specified type.
	///
	/// - Parameters:
	///   - type: The type of list wanted.
	///   - page: The number of the page to be downloaded.
	///   - completion: The handler to be called once the request has finished.
	public func fetchMoviesList(of type: ListType, on page: Int? = nil, _ completion: @escaping (FetchMoviesListResponse) -> Void) {
		let fullURLString = url(for: .movie) + type.rawValue
		let params = parameters([.page, .languageCode, .regionCode], forPage: page)
		
		httpNetworkWorker = HTTPNetworkWorker()
		httpNetworkWorker?.get(decodable: MoviesListResponse.self, from: fullURLString, with: params) { (response) in
			if let httpError = response.error {
				let internalError = self.getError(from: httpError)
				completion((false, nil, internalError))
				return
			}
			
			guard let moviesListResponse = response.decodable else {
				completion((false, nil, .Failure))
				return
			}
			
			completion((true, moviesListResponse, nil))
		}
	}
	
	//MARK:- Auxiliary Methods
	
	private func getError(from networkError: HTTPNetworkWorkerError) -> MoviesTMDbWorkerError {
		switch networkError {
		case .NoConnection:
			return .NoConnection
		case .MalformedData, .MalformedURL, .Failure:
			return .Failure
		}
	}
}
