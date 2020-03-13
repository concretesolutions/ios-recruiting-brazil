//
//  MoviesPosterResponse.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 13/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation
import UIKit

struct MoviePosterResponse {
    var banner: UIImage
    
    init(banner: UIImage) {
        self.banner = banner
    }
}
