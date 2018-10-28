//
//  UC05 - CachedGenres.swift
//  RealmPlatform
//
//  Created by Guilherme Guimaraes on 21/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain
import RealmSwift

public final class FilterUseCase: Domain.FilterUseCase {
	private let repository: GenresRepository
	
	public init(repository: GenresRepository) {
		self.repository = repository
	}
	
	public func fetchCachedGenres(handler: @escaping ([Genre]?, Error?) -> ()) {
		handler(self.repository.get(), nil)
	}
	
	public func fetchCachedGenres(with IDs: [Int], handler: @escaping ([Genre]?, Error?) -> ()) {
		handler(self.repository.get(with: IDs), nil)
	}
	
}

