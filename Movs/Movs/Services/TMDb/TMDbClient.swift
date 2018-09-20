//
//  TMDbClient.swift
//  Movs
//
//  Created by Lucas Ferraço on 15/09/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import Foundation

class TMDbClient {
	
	//MARK:- Auxiliary Structs
	
	internal enum EndPoint: String {
		case movie 			= "/movie"
		case configuration 	= "/configuration"
		case genre 			= "/genre"
	}
	
	internal enum Parameter: String {
		case page 			= "page"
		case languageCode	= "language"
		case regionCode 	= "region"
	}
	
	internal struct Properties: Decodable {
		let images: ImageProperties?
		
		struct ImageProperties: Decodable {
			var baseURL: String?
			var safeBaseURL: String?
			var backdropSizes: [String]?
			var posterSizes: [String]?
			
			private enum CodingKeys: String, CodingKey {
				case baseURL        = "base_url"
				case safeBaseURL    = "secure_base_url"
				case backdropSizes  = "backdrop_sizes"
				case posterSizes    = "poster_sizes"
			}
		}
	}
	
	
	//MARK:- API's properties
	
	private let baseURL = "https://api.themoviedb.org/3"
	private let apiKey = "ddf0ec95435edb3872ce496a4c1f7cd1"
	internal var properties: Properties?
	
	//MARK:- Shared Methods
	
	internal func url(for endPoint: EndPoint) -> String {
		return baseURL + endPoint.rawValue
	}
	
	internal func parameters(_ options: Set<Parameter> = [], forPage page: Int? = nil) -> [String : Any] {
		var params: [String : Any] = [:]
		params.updateValue(apiKey, forKey: "api_key")
		
		for option in options {
			switch option {
			case .page:
				if let page = page {
					params.updateValue(page, forKey: "page")
				}
			case .languageCode:
				if let languageCode = currentLanguageCode() {
					params.updateValue(languageCode, forKey: "language")
				}
			case .regionCode:
				if let regionCode = currentRegionCode() {
					params.updateValue(regionCode, forKey: "region")
				}
			}
		}
		
		return params
	}
	
	//MARK:- Auxiliary Methods
	
	private func currentLanguageCode() -> String? {
		let currentLocale = Locale.current
		return currentLocale.languageCode
	}
	
	private func currentRegionCode() -> String? {
		let currentLocale = Locale.current
		return currentLocale.regionCode
	}
}
