//
//  MoviesUseCase.swift
//  NetworkPlatform
//
//  Created by Guilherme Guimaraes on 21/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain
import Moya
import Alamofire

public final class PopularMoviesUseCase: Domain.PopularMoviesUseCase {
	private let provider : MoyaProvider<TMDB_Service>
	private let decoder : JSONDecoder
	
	var fetchPermission: Bool = true
	var timer = Timer()
	
	init(decoder: JSONDecoder = JSONDecoder.standardDecoder, provider: MoyaProvider<TMDB_Service> = .init(manager: Alamofire.SessionManager.standardManager)) {
		self.provider = provider
		self.decoder = decoder
	}
	
	private func validadeFetchPermission(allowed: @escaping ()->(), denied: @escaping () -> ()){
		if (fetchPermission == true){
			disableFetchPermission()
			runFetchTimer()
			allowed()
		} else {
			denied()
		}
	}
	
	private func runFetchTimer(){
		self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(enableFetchPermission), userInfo: nil, repeats: false)
	}
	
	@objc func enableFetchPermission(){
		self.fetchPermission = true
	}
	
	@objc func disableFetchPermission(){
		self.fetchPermission = false
	}
	
	public func fetchMovies(pageNumber: Int, handler: @escaping ([Movie]?, Error?) -> ()) {
		validadeFetchPermission(allowed: {
			self.requestMovies(pageNumber: pageNumber) { (movies, error) in
				if let error = error {
					handler(nil, error)
				} else {
					handler(movies, error)
				}
			}
		}) {
			handler(nil, ErrorProvider.standard(localizedDescription: "Fetch not permitted due to spam protection.") )
		}
		
	}
	
	private func requestMovies(pageNumber: Int, handler: @escaping ([Movie]?, Error?) -> ()) {
		provider.request(TMDB_Service.getPopularMovies(pageNumber: pageNumber)) { (result) in
			switch (result){
			case .success(let value):
				do {
					let movies = try value.map([Movie].self, atKeyPath: "results", using: self.decoder, failsOnEmptyData: false)
					handler(movies, nil)
				} catch {
					handler(nil, ErrorProvider.standard(localizedDescription: error.localizedDescription))
				}
			case.failure(let error):
				handler(nil, ErrorProvider.standard(localizedDescription: error.localizedDescription))
			}
		}
	}
}
