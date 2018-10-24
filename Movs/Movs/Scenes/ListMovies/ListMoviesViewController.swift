//
//  ListMoviesViewController.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright (c) 2018 Maisa Milena. All rights reserved.
//


import UIKit

protocol ListMoviesDisplayLogic: class {
  
}

class ListMoviesViewController: UIViewController {
    
      // Dependency
      var interactor: ListMoviesBusinessLogic?


      // MARK: - View lifecycle
      override func viewDidLoad() {
        super.viewDidLoad()
        ListMoviesSceneConfigurator.inject(dependenciesFor: self)
      }
    
    override func viewWillAppear(_ animated: Bool) {
        let request = ListMovies.Fetch.Request()
        interactor?.fetchPopularMovies(request: request)
    }
  
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
           
        }
    }
    
}

extension ListMoviesViewController: ListMoviesDisplayLogic {
    
}
