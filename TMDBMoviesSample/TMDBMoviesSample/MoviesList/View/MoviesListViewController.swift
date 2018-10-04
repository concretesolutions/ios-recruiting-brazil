//
//  MoviesListViewController.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 03/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {

    private lazy var presenter: MoviesListPresenterProtocol = MoviesListPresenter(with: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

//MARK: - ViewProtocol methods -
extension MoviesListViewController: MoviesListViewProtocol {}
