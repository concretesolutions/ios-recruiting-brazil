//
//  PopularMoviesErrorView+Initializers.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 23/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import UIKit

struct PopularMoviesErrorViewModel{
	
	private static let error = "Um error inexperado ocorreu."
	private static let emptySearch = "Sua busca por '%@' não há resultados."
	
	let image: UIImage
	let message: String
	
	static var standardError: PopularMoviesErrorViewModel {
		return PopularMoviesErrorViewModel(image: #imageLiteral(resourceName: "errorX"), message: error)
	}
	
	static func standard(searchText: String) -> PopularMoviesErrorViewModel {
		return PopularMoviesErrorViewModel(image: #imageLiteral(resourceName: "search_icon"), message: String(format: emptySearch, searchText))
	}
}
