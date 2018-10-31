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
import Alamofire

public final class StartupUseCase: Domain.StartupUseCase {
	private let provider : MoyaProvider<TMDB_Service>
	private let decoder : JSONDecoder
	
	init(decoder: JSONDecoder = JSONDecoder.standardDecoder, provider: MoyaProvider<TMDB_Service> = .init(manager: Alamofire.SessionManager.standardManager)) {
		self.provider = provider
		self.decoder = decoder
	}
	
	public func fetchGenres(handler: @escaping (Domain.Result<[Genre]>) -> ()) {
		requestGenres { (result) in
			switch result {
			case .success(let value):
				handler(Domain.Result<[Genre]>.success(value))
			case .failure(let error):
				handler(Domain.Result<[Genre]>.failure(error))
			}
		}
	}
	
	private func requestGenres(handler: @escaping (Domain.Result<[Genre]>) -> ()) {
		provider.request(TMDB_Service.getGenres) { (result) in
			switch result {
			case .success(let value):
				do {
					let genres = try value.map([Genre].self, atKeyPath: "genres", using: self.decoder, failsOnEmptyData: false)
					handler(Domain.Result<[Genre]>.success(genres))
				} catch {
					handler(Domain.Result<[Genre]>
						.failure(NetworkDomainError(errorCode: NetworkErrorCode.decodingError, error: error).value()))
				}
			case .failure(let error):
				handler(Domain.Result<[Genre]>
					.failure(NetworkDomainError(errorCode: NetworkErrorCode.responseError, error: error).value()))
			}
		}
	}
}

