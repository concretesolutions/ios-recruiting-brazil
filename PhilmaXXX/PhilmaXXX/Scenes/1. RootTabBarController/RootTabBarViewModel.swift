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
	private let environmentSetupUseCase: Domain.EnvironmentSetupUseCase
	
	init(startupUseCase: Domain.StartupUseCase, environmentSetupUseCase: Domain.EnvironmentSetupUseCase) {
		self.startupUseCase = startupUseCase
		self.environmentSetupUseCase = environmentSetupUseCase
	}
	
	func fetchGenresAndSetInCache(){
		startupUseCase.fetchGenres { (result) in
			switch result {
			case .success(let value):
				self.environmentSetupUseCase.setInCache(value)
			case .failure(_):
				break
			}
		}
	}

}
