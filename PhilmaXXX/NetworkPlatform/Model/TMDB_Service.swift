//
//  TMDB_Service.swift
//  NetworkPlatform
//
//  Created by Guilherme Guimaraes on 21/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Moya

enum TMDB_Service {
	case getPopularMovies(pageNumber: Int)
	case getGenres
}

extension TMDB_Service: TargetType {
	var baseURL: URL {
		return URL(string: "https://api.themoviedb.org/3/")!
	}
	
	var path: String {
		switch self {
		case .getPopularMovies(_):
			return "movie/popular"
		case .getGenres:
			return "genre/movie/list"
		}
	}
	
	var method: Moya.Method {
		return .get
	}
	
	var sampleData: Data {
		switch self {
		case .getPopularMovies(_):
			let fileURL = Bundle(for: PopularMoviesUseCase.self).url(forResource: "getPopularMovies-1", withExtension: "json") ?? URL(fileURLWithPath: "")
			let data = try? Data(contentsOf: fileURL)
			return data ?? "{}".utf8Encoded
		case .getGenres:
			let fileURL = Bundle(for: StartupUseCase.self).url(forResource: "getGenres", withExtension: "json") ?? URL(fileURLWithPath: "")
			let data = try? Data(contentsOf: fileURL)
			return data ?? "{}".utf8Encoded
		}
	}
	
	var task: Task {
		switch self {
		case .getPopularMovies(let page):
			var params = defaultParameters
			params["page"] = page
			return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
		case .getGenres:
			return .requestParameters(parameters: defaultParameters, encoding: URLEncoding.queryString)
		}
	}
	
	var headers: [String : String]? {
		return ["Content-type": "application/json"]
	}
	
	var defaultParameters : [String: Any] {
		let params = ["api_key": "5d2b2a81c25598f5ae121d3c5428afba",
					  "language": "pt-BR"]
		return params
	}
}
