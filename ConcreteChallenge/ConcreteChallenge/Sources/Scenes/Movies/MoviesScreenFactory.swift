//
//  MoviesScreenFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 23/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum MoviesScreenFactory {
    static func makeMovies() -> UIViewController {
        let moviesViewController = MoviesViewController()

        return moviesViewController
    }
}
