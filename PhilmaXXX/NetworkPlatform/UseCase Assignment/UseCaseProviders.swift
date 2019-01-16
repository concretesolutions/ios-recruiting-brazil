//
//  UseCaseProviders.swift
//  NetworkPlatform
//
//  Created by Guilherme Guimaraes on 21/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

public final class StartupUseCaseProvider: Domain.StartupUseCaseProvider {
	
	public init() { }
	
	public func useCase() -> Domain.StartupUseCase {
		let useCase = StartupUseCase()
		return useCase
	}
	
}

public final class PopularMoviesUseCaseProvider: Domain.PopularMoviesUseCaseProvider {

	public init() { }

	public func useCase() -> Domain.PopularMoviesUseCase {
		let useCase = PopularMoviesUseCase()
		return useCase
	}
}
