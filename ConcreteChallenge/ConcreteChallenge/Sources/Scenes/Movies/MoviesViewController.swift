//
//  MovieViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 23/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let provider = MovieDBNetworkService()
        provider.getMovies()
    }
}
