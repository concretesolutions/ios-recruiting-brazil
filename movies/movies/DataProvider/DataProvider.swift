//
//  DataProvider.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

protocol DataProvidable {
    var popularMovies: [Movie] { get set }
    var favoriteMovies: [Movie] { get }
}
