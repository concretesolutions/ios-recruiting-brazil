//
//  MovieRouter.swift
//  movs
//
//  Created by Renan Oliveira on 17/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

struct MovieRouter {
    static func pushMovieDetailViewController(_ fromViewController: UIViewController?, movie: MovieData) {
        if let viewController = fromViewController {
            let destineViewController: MovieDetailViewController = StoryboadsUtil.Movies.main.instantiateViewController(withIdentifier: MovieDetailViewController.identifier) as! MovieDetailViewController
            destineViewController.movie = movie
            viewController.navigationController?.pushViewController(destineViewController, animated: true)
        }
    }
}
