//
//  StartupUseCase.swift
//  NetworkPlatform
//
//  Created by Guilherme Guimaraes on 21/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain
import Moya

public final class StartupUseCase: Domain.StartupUseCase {
	private let provider : MoyaProvider<TMDB_Service>
	private let decoder : JSONDecoder
	
	init(decoder: JSONDecoder = JSONDecoder.standardDecoder, provider: MoyaProvider<TMDB_Service> = .init(manager: AlamofireManager.standard)) {
		self.provider = provider
		self.decoder = decoder
	}
	
	public func fetchGenres(handler: @escaping ([Genre]?, Error?) -> ()) {
		requestGenres { (genres, error) in
			if let error = error {
				handler(nil, error)
			} else {
				handler(genres, nil)
			}
		}
	}
	
	private func requestGenres(handler: @escaping ([Genre]?, Error?) -> ()) {
		provider.request(TMDB_Service.getGenres) { (result) in
			switch result {
			case .success(let value):
				do {
					let genres = try value.map([Genre].self, atKeyPath: "genres", using: self.decoder, failsOnEmptyData: false)
					handler(genres, nil)
				} catch {
					handler(nil, ErrorProvider.standard(localizedDescription: error.localizedDescription))
				}
			case .failure(let error):
				handler(nil, ErrorProvider.standard(localizedDescription: error.localizedDescription))
			}
		}
	}
}

