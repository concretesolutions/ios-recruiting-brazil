//
//  UIImageView+Nuke.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation
import UIKit
import Nuke

extension UIImageView {
    func loadImageFrom(_ path: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/w342" + path)!

        ImagePipeline.shared.loadImage(with: url, progress: { (response, _, _) in
            guard let response = response else {
                return
            }
            
            self.image = response.image
            
        }) { (response, error) in
            //
        }
    }
 }
