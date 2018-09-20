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
	
	/// Download the image from the specified movie.
	///
	/// - Parameters:
	///   - movie: The movie to download an image.
	///   - completion: The handler to be called once the download has finished.
	public func downloadImage(for movie: TMDbMovie, _ completion: @escaping (DownloadImageResponse) -> Void) {
		let imageMetadata = getImageMetadata(for: movie)
		var downloadResponse = DownloadImageResponse(false, imageMetadata.path, nil)
		
		guard let properties = properties else {
			updateProperties() { (error) in
				guard error == nil else {
					completion(downloadResponse)
					return
				}
				
				self.downloadImage(for: movie, completion)
			}
			
			return
		}
		
		guard let preferredImageURL = properties.images?.safeBaseURL else {
			completion(downloadResponse)
			return
		}
		
		let completeURL = preferredImageURL + imageMetadata.type.getDefaultSizeString() + imageMetadata.path
		httpNetworkWorker = HTTPNetworkWorker()
		httpNetworkWorker?.downloadData(from: completeURL) { (response) in
			guard let unwrappedData = response.data else {
				completion(downloadResponse)
				return
			}
			
			if downloadResponse.path == imageMetadata.path { // Avoid the image to load on the wrong spot
				downloadResponse.success = true
				downloadResponse.imageData = unwrappedData
				
				print("--- Downloaded \(imageMetadata.type) for \(movie.title ?? "") ---")
				completion(downloadResponse)
			}
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
	
	/// Gets the preferrable image metadata (path andd type) for the specified movie.
	///
	/// - Parameter movie: The movie to get image info.
	/// - Returns: A tuple containing path and type of the preferrable image.
	private func getImageMetadata(for movie: TMDbMovie) -> (path: String, type: ImageTMDbWorker.ImageType) {
		var path = ""
		var imageType: ImageTMDbWorker.ImageType = .poster
		if let posterPath = movie.posterPath {
			path = posterPath
		} else if let backdropPath = movie.backdropPath {
			path = backdropPath
			imageType = .backdrop
		}
		
		return (path, imageType)
	}
	
}
