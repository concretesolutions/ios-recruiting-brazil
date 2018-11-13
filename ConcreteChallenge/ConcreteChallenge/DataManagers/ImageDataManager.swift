//
//  ImageDataManager.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 13/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class ImageDataManager {
    
    static let rootPath = "https://image.tmdb.org/t/p/w500"
    
    static func getImageFrom(imagePath: String, completion: @escaping (_ image: UIImage) -> Void) {
        
        guard let imageURL = URL(string: rootPath + imagePath) else { return }
        var request = URLRequest(url: imageURL)
        request.httpMethod = "GET"
        
        // Making GET api request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error == nil {
                guard let data = data else { return }
                
                // Get image
                if let image = UIImage(data: data) {
                    completion(image)
                } else {
                    return
                }
                
            } else {
                print("Error downloading image: ", error as Any)
            }
        }.resume()
    }
}
