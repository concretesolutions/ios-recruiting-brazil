//
//  ErrorProvider.swift
//  NetworkPlatform
//
//  Created by Guilherme Guimaraes on 21/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Moya

enum ErrorProvider: Error {
	case standard(localizedDescription: String)	
}
