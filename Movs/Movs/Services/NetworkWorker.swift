//
//  NetworkWorker.swift
//  Movs
//
//  Created by Lucas Ferraço on 15/09/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPNetworkWorkerError: Error {
	case NoConnection
	case MalformedURL
	case MalformedData
	case Failure
}

class HTTPNetworkWorker {
	
	typealias GetDecodableResult<T> = (sucess: Bool, decodable: T?, error: HTTPNetworkWorkerError?) where T : Decodable
	
	/// Makes a HTTP GET request and retrieves its decodable data.
	///
	/// - Parameters:
	///   - urlString: The string representing the complete URL path.
	///   - parameters: The parameters.
	///   - headers: The headers.
	///   - completion: The handler to be called once the request has finished.
	public func get<T>(decodable: T.Type, from urlString: String, with parameters: [String : Any]? = nil, headers: [String : String]? = nil, _ completion: @escaping (GetDecodableResult<T>) -> Void) where T : Decodable {
		guard hasConnection() else {
			return completion((false, nil, .NoConnection))
		}
		
		if let url = URL(string: urlString) {
			Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
				.validate()
				.responseData { (response) in
					guard response.result.isSuccess else {
						completion((false, nil, .Failure))
						return
					}
					
					guard let decodableData = response.result.value else {
						completion((false, nil, .MalformedData))
						return
					}
					
					do {
						let jsonDecoder = JSONDecoder()
						let obj = try jsonDecoder.decode(T.self, from: decodableData)
						
						completion((true, obj, nil))
					}
					catch _ {
						completion((false, nil, .MalformedData))
					}
			}
		} else {
			completion((false, nil, .MalformedURL))
		}
	}
	
	typealias DownloadResult = (success: Bool, data: Data?, error: HTTPNetworkWorkerError?)
	
	/// Downloads the data from the specified URL.
	///
	/// - Parameters:
	///   - urlString: The string representing the complete URL path.
	///   - completion: The handler to be called once the request has finished.
	public func downloadData(from urlString: String, _ completion: @escaping (DownloadResult) -> Void) {
		guard hasConnection() else {
			return completion((false, nil, .NoConnection))
		}
		
		if let url = URL(string: urlString) {
			Alamofire.request(url, method: .get)
				.validate()
				.responseData { (response) in
					guard response.result.isSuccess else {
						completion((false, nil, .Failure))
						return
					}
					
					guard let data = response.result.value else {
						completion((false, nil, .MalformedData))
						return
					}
					
					completion((true, data, nil))
			}
		} else {
			completion((false, nil, .MalformedURL))
		}
	}
	
	//MARK:- Auxiliary methods
	
	/// Verify if the network is currently reachable.
	///
	/// - Returns: Whether the network is currently reachable.
	private func hasConnection() -> Bool {
		if let connectionManager = Alamofire.NetworkReachabilityManager() {
			return connectionManager.isReachable
		}
		
		return false
	}
}
