//
//  MovieViewModel.swift
//  Concrete
//
//  Created by Vinicius Brito on 20/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import UIKit

class MovieViewModel {
    var title: String?
    var image: String?

    init (item: Result) {
        self.title = item.originalTitle
        self.image = item.posterPath
    }
}
