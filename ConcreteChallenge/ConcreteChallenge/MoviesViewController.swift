//
//  ViewController.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 10/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var movieCollection: MovieColletion
    
    private init() {
        self.movieCollection = MovieColletion()
        super.init(nibName: nil, bundle: nil)
    }
    
    init(movieCollection: MovieColletion) {
        self.movieCollection = movieCollection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        ServiceLayer.request(router: Router.getMovies) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let response):
                self.movieCollection.addMovies(response.results)
            case .failure(let error):
                print(error)
            }
        }
    }


}

