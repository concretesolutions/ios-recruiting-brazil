//
//  2 - SetupUseCase.swift
//  RealmPlatform
//
//  Created by Guilherme Guimaraes on 21/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

public final class SetupUseCase: Domain.SetupUseCase {
	private let repository: GenresRepository
	
	public init(repository: GenresRepository) {
		self.repository = repository
	}
	
	public func setInCache(_ genres: [Genre]) {
		self.repository.deleteAll()
		self.repository.set(objects: genres)
	}
	
}
