//
//  PopularMoviesNetworkWorker.swift
//  Movs
//
//  Created by Tiago Chaves on 12/08/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit

class PopularMoviesNetworkWorker:PopularMoviesListWorkerProtocol {
	
	func getPopularMovies(_ page: Int, completion: @escaping (() throws -> PopularMoviesResult) -> Void) {
		
		let request = MovsRequests.popularMovies(page)
		
		NetworkManager.request(withURL: request) { (data, response, error) in
			
			if error == nil, let data = data {
				
				do {
					let decoder = JSONDecoder()
					decoder.dateDecodingStrategy = .formatted(DateFormatter.ymd)
					let result = try decoder.decode(PopularMoviesResult.self, from: data)
					
					completion { return result }
				}catch let error {
					
					completion { throw error }
				}
			}else{
				
				completion { throw error! }
			}
		}
	}
}

enum MovsError: Error {
	case unauthorized
	case notFound
}
