//
//  ListMoviesViewController.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright (c) 2018 Maisa Milena. All rights reserved.
//


import UIKit

protocol ListMoviesDisplayLogic: class {
    func displayMovies(viewModel: ListMovies.ViewModel.Success)
    func displayError(viewModel: ListMovies.ViewModel.Error)
}

class ListMoviesViewController: UIViewController {
    
    // Initial configuration
    var interactor: ListMoviesBusinessLogic?
    let movieCellReuseIdentifier = "PopularMovieTableViewCell"
    let detailMovieSegue = "detailMovie"
    
    // Auxiliar
    private var page: Int = 1
    var fetchingMovies = false
    
    @IBOutlet weak var tableView: UITableView!

    // Data
    var movies = [ListMovies.ViewModel.PopularMoviesFormatted]()
    let moviesLimitToPresent = 50
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ListMoviesSceneConfigurator.inject(dependenciesFor: self)
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        // Start presenting the first page
        let request = ListMovies.Request(page: page)
        interactor?.fetchPopularMovies(request: request)
    }

    // MARK: - Setup
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        configureNavigationController()
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.view.tintColor = .darkGray
        navigationController?.view.backgroundColor = .white
        navigationItem.title = "Mais populares"
    }

    // MARK: - Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == detailMovieSegue) {
            let viewController = segue.destination as! DetailMoviesViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            let movieId = movies[indexPath!.row].id
            viewController.movieId = movieId
        }
    }
    
}
// MARK: - Display Logic
extension ListMoviesViewController: ListMoviesDisplayLogic {
    
    func displayMovies(viewModel: ListMovies.ViewModel.Success) {
        movies.append(contentsOf: viewModel.movies)
        tableView.reloadData()
        fetchingMovies = false
    }
    
    func displayError(viewModel: ListMovies.ViewModel.Error) {
        let viewError = MovieListErrorView(frame: view.frame, image: viewModel.image!, message: viewModel.message)
        view.addSubview(viewError)
    }

}

extension ListMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: detailMovieSegue, sender: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            loadMoreData()
            tableView.reloadData()
        }
    }
    
    private func loadMoreData() {
        if !fetchingMovies{
            page += 1
            fetchingMovies = true
            let request = ListMovies.Request(page: page)
            interactor?.fetchPopularMovies(request: request)
        }
    }
}

