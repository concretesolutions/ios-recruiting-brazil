//
//  DefaultManager.swift
//  NetworkPlatform
//
//  Created by Guilherme Guimaraes on 21/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import Foundation
import Alamofire

extension Alamofire.SessionManager {
	public static var standardManager: Alamofire.SessionManager {
		let configuration = URLSessionConfiguration.default
		configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
		return Alamofire.SessionManager(configuration: configuration)
	}
}
