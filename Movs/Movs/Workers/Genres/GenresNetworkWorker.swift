//
//  GenresNetworkWorker.swift
//  Movs
//
//  Created by Tiago Chaves on 14/08/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import Foundation

final class GenresNetworkWorker: GenresListWorkerProtocol {
	
	func getGenresList(completionHandler: @escaping (() throws -> [GenreData]) -> Void) {
		
		NetworkManager.request(withURL: MovsRequests.genres) { (data, response, error)  in
			
			if error == nil, let data = data{
				do{
					let jsonDecoder = JSONDecoder()
					let responseModel = try jsonDecoder.decode(GenresResult.self, from: data)
					NSLog("\(responseModel.genres.count) genres returned")
					completionHandler{ return responseModel.genres }
				}catch let error {
					completionHandler{ throw error }
				}
			}else{
				completionHandler{ throw error! }
			}
		}
	}
}
