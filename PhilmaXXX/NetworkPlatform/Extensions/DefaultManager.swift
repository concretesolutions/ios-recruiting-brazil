//
//  DefaultManager.swift
//  NetworkPlatform
//
//  Created by Guilherme Guimaraes on 21/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireManager: Alamofire.SessionManager {
	static let standard: AlamofireManager = {
		let configuration = URLSessionConfiguration.default
		configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
		return AlamofireManager(configuration: configuration)
	}()
}
