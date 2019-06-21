//
//  MoviePosterResponse.swift
//  Movs
//
//  Created by Filipe Merli on 20/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation
import UIKit

struct MoviePosterResponse {
    var banner: UIImage
    
    init(banner: UIImage) {
        self.banner = banner
    }
}
