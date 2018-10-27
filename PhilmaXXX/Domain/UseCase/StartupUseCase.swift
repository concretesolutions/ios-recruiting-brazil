//
//  StartupUseCase.swift
//  Domain
//
//  Created by Guilherme Guimaraes on 21/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

public protocol StartupUseCase {
	func fetchGenres(handler: @escaping ([Genre]?, Error?) -> ()) 
}
