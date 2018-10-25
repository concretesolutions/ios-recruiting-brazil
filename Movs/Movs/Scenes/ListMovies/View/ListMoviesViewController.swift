//
//  ListMoviesViewController.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright (c) 2018 Maisa Milena. All rights reserved.
//


import UIKit

protocol ListMoviesDisplayLogic: class {
    func displayMovies(viewModel: ListMovies.Fetch.ViewModel.Success)
    func displayError(viewModel: ListMovies.Fetch.ViewModel.Error)
}

class ListMoviesViewController: UIViewController {
    
    // Initial configuration
    var interactor: ListMoviesBusinessLogic?
    private var page: Int = 1
    let movieCellReuseIdentifier = "PopularMovieTableViewCell"
    
    @IBOutlet weak var tableView: UITableView!

    // Data
    var movies = [Movie]()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ListMoviesSceneConfigurator.inject(dependenciesFor: self)
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        let request = ListMovies.Fetch.Request()
        interactor?.fetchPopularMovies(request: request)
    }

    // MARK: - Setup
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.title = "Mais populares"
    }
  
    
    // MARK: - Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
           
        }
    }
    
}

extension ListMoviesViewController: ListMoviesDisplayLogic {
    
    func displayMovies(viewModel: ListMovies.Fetch.ViewModel.Success) {
        movies = viewModel.movies
        tableView.reloadData()
        print("🦊 receiving movies in VC")
    }
    
    func displayError(viewModel: ListMovies.Fetch.ViewModel.Error) {
        
    }

}

extension ListMoviesViewController: UITableViewDelegate {
    
}


