//
//  NetworkDomainError.swift
//  NetworkPlatform
//
//  Created by Guilherme Guimaraes on 31/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Domain

enum NetworkErrorCode: String {
	case decodingError = "NEC0001"
	case responseError = "NEC0002"
	case spamProtectionError = "NEC0003"
}

enum NetworkDomainError {
	case decodingError(Error)
	case responseError(Error)
	case spamProtectionError(Error)
	
	init(errorCode: NetworkErrorCode, error: Error){
		switch errorCode {
		case .decodingError:
			self = .decodingError(error)
		case .responseError:
			self = .responseError(error)
		case .spamProtectionError:
			self = .spamProtectionError(error)
		}
	}
	
	func value() -> DomainError {
		switch self {
		case .decodingError(let error):
			return DomainError(errorCode: NetworkErrorCode.decodingError.rawValue, error: error)
		case .responseError(let error):
			return DomainError(errorCode: NetworkErrorCode.responseError.rawValue, error: error)
		case .spamProtectionError(let error):
			return DomainError(errorCode: NetworkErrorCode.spamProtectionError.rawValue, error: error)
		}
	}
}
