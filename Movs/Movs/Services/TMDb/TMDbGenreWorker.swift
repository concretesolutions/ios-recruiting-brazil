//
//  TMDbGenreWorker.swift
//  Movs
//
//  Created by Lucas Ferraço on 16/09/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import Foundation

class TMDbGenreWorker: TMDbClient {
	
	private var httpNetworkWorker: HTTPNetworkWorker?
	private var movieList: [Genre]? = nil
	private var tvList: [Genre]? = nil
	
	public enum Kind: String {
		case movie	= "/movie"
		case tv		= "/tv"
	}
	
	private struct GenreListResponse: Decodable {
		let genres: [Genre]
	}
	
	public struct Genre: Decodable {
		let id: Int
		let name: String
	}
	
	//MARK:- Public Methods
	
	/// Downloads a list of genres according to the specified kind.
	///
	/// - Parameters:
	///   - kind: Whether tv or movie genres.
	///   - completion: The handler to be called once the request has finished.
	public func fetchGenres(of kind: Kind, _ completion: (([Genre]?) -> Void)? = nil) {
		if let list = checkForDownloadedList(of: kind) {
			completion?(list)
			return
		}
		
		let completeURL = url(for: .genre) + kind.rawValue + "/list"
		let params = parameters([.languageCode])
		
		httpNetworkWorker = HTTPNetworkWorker()
		httpNetworkWorker?.get(decodable: GenreListResponse.self, from: completeURL, with: params) { (response) in
			guard let list = response.decodable else {
				completion?(nil)
				return
			}
			
			self.storeDownloaded(list: list.genres, of: kind)
			completion?(list.genres)
		}
	}
	
	//MARK:- Auxiliary Methods
	
	private func checkForDownloadedList(of kind: Kind) -> [Genre]? {
		switch kind {
		case .movie:
			return movieList
		case .tv:
			return tvList
		}
	}
	
	private func storeDownloaded(list: [Genre], of kind: Kind) {
		switch kind {
		case .movie:
			movieList = list
		case .tv:
			tvList = list
		}
	}
	
}
