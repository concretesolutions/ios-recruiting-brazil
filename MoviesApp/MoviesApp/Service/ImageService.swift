//
//  ImageService.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 04/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import Foundation

class ImageService: BaseService {
    
    typealias ImageConfigCompletion = (_ config: ImageServiceConfig?) -> ()
    
    func loadImageConfig(completion: @escaping ImageConfigCompletion) {
        self.serviceResponse(method: .get, path: "/configuration") { (_code, _result, _error) in
            if _error != nil {
                completion(nil)
            } else if let code = _code, let httpCode = HTTPResponseCode(rawValue: code) {
                switch httpCode {
                case .success:
                    if let result = _result as? [String:Any], let imageData = result["images"] as? [String:Any] {
                        var sizes: [Int] = []
                        if let sizesData = imageData["logo_sizes"] as? [String] {
                            sizes = sizesData.compactMap{Int($0.trimmingCharacters(in: CharacterSet.letters))}
                        }
                        completion(ImageServiceConfig(safeUrl: String(safeValue: imageData["secure_base_url"]),
                                                      availableSizes: sizes))
                    } else {
                        completion(nil)
                    }
                default:
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
}
