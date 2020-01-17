//
//  PopularMoviesViewController.swift
//  theMovie-app
//
//  Created by Adriel Alves on 26/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    
    @IBOutlet weak var cvPopularMovies: UICollectionView!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var errorView: ErrorView!
    
    
    private let cellIdentifier = "ItemCollectionViewCell"
    private var popularMovies = PopularMoviesViewModel()
    private var movies: [MovieViewModel] = []
    private var itemCollectionViewCell = ItemCollectionViewCell()
    private let appearance = UINavigationBarAppearance()
    
    var loading = false
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popularMovies.delegate = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cvPopularMovies?.reloadData()
    }
    
    private func setupUI(){
        setupNavigationBarAppearance(appearance: appearance)
        setupSearchController(delegate: self)
        requestMovies()
        setupCollectionView()
        setupItemCollectionViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailViewController {
            if let movie = sender as? MovieViewModel {
                vc.movieDetail = movie
            }
        }
    }
    
    func setupCollectionView() {
        cvPopularMovies.delegate = self
        cvPopularMovies.dataSource = self
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        cvPopularMovies.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func setupItemCollectionViewCell() {
        itemCollectionViewCell.setupCollectionViewItemSize(with: cvPopularMovies)
    }
    
    private func requestMovies() {
        loading = true
        aiLoading.startAnimating()
        popularMovies.requestMovies(currentPage: currentPage)
    }
}

extension PopularMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cvPopularMovies.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.prepare(with: movies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.item]
        performSegue(withIdentifier: "movieDetailSegue", sender: movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 10 && !loading && movies.count != popularMovies.total{
            currentPage += 1
            popularMovies.requestMovies(currentPage: currentPage)
        }
    }
    
    func filterMovies(searchText: String) -> [MovieViewModel] {
        
        if searchText.isEmpty {
            movies = popularMovies.movies
        } else {
            movies = popularMovies.movies.filter({$0.title.lowercased().contains(searchText.lowercased())})
//            movies = popularMovies.movies.filter { (movie) -> Bool in
//                hasResult = movie.title.lowercased().contains(searchText.lowercased())
//                return hasResult
            }
        return movies
        }
    }

extension PopularMoviesViewController: PopularMoviesViewModelDelegate {
    
    func didFinishSuccessRequest() {
        movies = popularMovies.movies
        self.cvPopularMovies?.reloadData()
        aiLoading.stopAnimating()
        loading = false
    }
    
    func didFinishFailureRequest(error: APIError) {
        errorView.type = .genericError
        errorView.isHidden = false
        errorView.delegate = self
        print(APIError.taskError(error: error))
    }
}

extension PopularMoviesViewController: ErrorViewDelegate {
    func errorViewAction() {
        requestMovies()
        errorView.isHidden = true
    }
}

extension PopularMoviesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let searchText = searchBar.text else { return }
        
        if filterMovies(searchText: searchText).count == 0 {
            errorView.type = .notFound(searchText: searchText)
            errorView.isHidden = false
        }
         cvPopularMovies?.reloadData()

    }
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        errorView.isHidden = true
        movies = popularMovies.movies
        cvPopularMovies?.reloadData()
        
    }
}
