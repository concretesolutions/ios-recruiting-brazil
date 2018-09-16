//
//  ImageTMDbWorker.swift
//  Movs
//
//  Created by Lucas Ferraço on 16/09/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import Foundation

class ImageTMDbWorker: TMDbClient {
	
	private var httpNetworkWorker: HTTPNetworkWorker?
	
	public enum ImageType {
		case poster
		case backdrop
		
		func getDefaultSizeString() -> String {
			switch self {
			case .poster:
				return "w500"
			case .backdrop:
				return "w300"
			}
		}
	}
	
	override init() {
		super.init()
		updateProperties()
	}
	
	// MARK:- Shared Methods
	
	typealias DownloadImageResponse = (success: Bool, path: String, imageData: Data?)
	
	/// Download the image from the specified URL.
	///
	/// - Parameters:
	///   - path: The file path to be downloaded.
	///   - type: Whether poster or backdrop image.
	///   - completion: The handler to be called once the download has finished.
	public func downloadImage(from path: String, type: ImageType, _ completion: @escaping (DownloadImageResponse) -> Void) {
		var downloadResponse = DownloadImageResponse(false, path, nil)
		
		guard let properties = properties else {
			updateProperties() { (error) in
				guard error == nil else {
					completion(downloadResponse)
					return
				}
				
				self.downloadImage(from: path, type: type, completion)
			}
			
			return
		}
		
		guard let preferredImageURL = properties.images?.safeBaseURL else {
			completion(downloadResponse)
			return
		}
		
		let completeURL = preferredImageURL + type.getDefaultSizeString() + path
		httpNetworkWorker = HTTPNetworkWorker()
		httpNetworkWorker?.downloadData(from: completeURL) { (response) in
			guard let unwrappedData = response.data else {
				completion(downloadResponse)
				return
			}
			
			downloadResponse.success = true
			downloadResponse.imageData = unwrappedData
			completion(downloadResponse)
		}
	}
	
	// MARK:- Auxiliary Methods
	
	private func updateProperties(_ completion: ((HTTPNetworkWorkerError?) -> Void)? = nil) {
		let propsURL = url(for: .configuration)
		let params = parameters()
		
		httpNetworkWorker = HTTPNetworkWorker()
		httpNetworkWorker?.get(decodable: Properties.self, from: propsURL, with: params) { (response) in
			guard let properties = response.decodable else {
				if let error = response.error {
					completion?(error)
				} else {
					completion?(.Failure)
				}
				
				return
			}
			
			self.properties = properties
			completion?(nil)
		}
	}
}
