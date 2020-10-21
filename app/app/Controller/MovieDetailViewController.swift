//
//  MovieDetailViewController.swift
//  app
//
//  Created by rfl3 on 21/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    let screen = MovieDetailViewControllerView()
    var movie: Movie? {
        didSet {
            self.screen.movie = self.movie
        }
    }

    override func loadView() {
        self.view = self.screen
    }
}
