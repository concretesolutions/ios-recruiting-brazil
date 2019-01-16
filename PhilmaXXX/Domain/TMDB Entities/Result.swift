//
//  Result.swift
//  Domain
//
//  Created by Guilherme Guimaraes on 31/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation

public struct DomainError {
	public let errorCode: String
	public let error: Error
	
	public init (errorCode: String, error: Error){
		self.errorCode = errorCode
		self.error = error
	}
}

public enum Result<T> {
	case success(T)
	case failure(DomainError)
}
