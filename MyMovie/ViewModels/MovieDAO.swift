//
//  MovieViewModel.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 25/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//

import UIKit
import Moya

enum ErrorLocalized: Error {
	case localizedError(localizedDescription: String)
	
}
class MovieDAO: NSObject {
	 static var provider = MoyaProvider<MyMovie>()
	

	
	static func get(endpoint: MyMovie, handler: @escaping (Data?, Error?) -> ()){
		provider.request(endpoint) { (result) in
			switch result{
			case .success(let data):
				handler(data.data, nil)

			case .failure(let error):
				handler(nil, ErrorLocalized.localizedError(localizedDescription: error.localizedDescription))
			}
		}
	}
	

}
