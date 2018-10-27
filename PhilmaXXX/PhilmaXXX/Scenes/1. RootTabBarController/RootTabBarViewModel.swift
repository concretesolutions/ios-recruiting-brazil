//
//  RootTabBarModel.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 21/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

final class RootTabBarViewModel {
	private let startupUseCase: Domain.StartupUseCase
	private let setupUseCase: Domain.SetupUseCase
	
	init(startupUseCase: Domain.StartupUseCase, setupUseCase: Domain.SetupUseCase) {
		self.startupUseCase = startupUseCase
		self.setupUseCase = setupUseCase
	}
	
	func fetchGenresAndSetInCache(){
		startupUseCase.fetchGenres { (genres, error) in
			if let genres = genres {
				self.setupUseCase.setInCache(genres)
			} else {
				print(error?.localizedDescription ?? "")
			}
		}
	}

}
