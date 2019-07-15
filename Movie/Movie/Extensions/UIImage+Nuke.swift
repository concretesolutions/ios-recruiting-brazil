//
//  UIImage+Nuke.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation
import UIKit
import Nuke

extension UIImage {
    static func loadFrom(_ path: String, completion: @escaping (UIImage?, Error?) -> ()) {
        let url = URL(string: "https://image.tmdb.org/t/p/w342" + path)!

        ImagePipeline.shared.loadImage(with: url, progress: { (response, _, _) in
                        
        }) { (response, error) in
            guard let response = response else {
                completion(nil, error)
                return
            }
            completion(response.image, nil)
        }
    }
 }
