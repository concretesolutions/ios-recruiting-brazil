//
//  Constants.swift
//  Concrete
//
//  Created by Vinicius Brito on 20/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import Foundation

struct ConstUrl {

    struct Cells {
        static let moviesCellId = "movieCell"
    }

    static func url(page: String) -> String {
        return "https://api.themoviedb.org/3/movie/popular?api_key=ce366837ba5968caa2ede95e28c38fcd&language=en-US&page=\(page)"
    }
}
