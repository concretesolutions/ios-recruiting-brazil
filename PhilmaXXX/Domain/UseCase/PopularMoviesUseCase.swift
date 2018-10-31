//
//  Generic Provider.swift
//  Domain
//
//  Created by Guilherme Guimaraes on 20/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

public protocol PopularMoviesUseCase {
	func fetchMovies(pageNumber: Int, handler: @escaping (Result<[Movie]>) -> ()) 
	
}
