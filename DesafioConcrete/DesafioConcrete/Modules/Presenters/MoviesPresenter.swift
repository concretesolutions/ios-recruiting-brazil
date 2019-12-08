//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

//MARK: View -
protocol MoviesViewProtocol: class {
    
    var presenter: MoviesPresenterProtocol?  { get set }
    
    func requestCollectionSetup()
    func createActivityIndicator()
    func changeIsAnimating(to animation: Bool)
    func setupSearchController()
    func reloadCollectionView()
    func showResultImage(isHidden: Bool, text: String)
    /* Presenter -> ViewController */
}

//MARK: Presenter -
protocol MoviesPresenterProtocol: class {
    
    var interactor: MoviesInteractorInputProtocol? { get set }
    var collectionViewDatasource: MoviesCollectionDataSource? { get set }
    var collectionViewDelegate: MoviesCollectionDelegate? { get set }
    var movies: [Movie]? { get set }
    var numberOfPages: Int { get set }
    var fetchingMore: Bool { get set }
    var isSearching: Bool { get set }
    var filteredMovies: [Movie]? { get set }
    func setupView(with collection: UICollectionView, isSearchBarEmpty: Bool)
    func requestData()
    func callCreateActivityIndicator()
    func setAnimation(to: Bool)
    func callSetupSearchController()
    func filterMovies(using text: String)
    /* ViewController -> Presenter */
}

final class MoviesPresenter: MoviesPresenterProtocol {
    
    var collectionViewDatasource: MoviesCollectionDataSource?
    var collectionViewDelegate: MoviesCollectionDelegate?
    var movies: [Movie]?
    var numberOfPages: Int = 1
    var fetchingMore: Bool = false
    var isSearching: Bool = false
    var filteredMovies: [Movie]? = []
    
    weak private var view: MoviesViewProtocol?
    var interactor: MoviesInteractorInputProtocol?
    private let router: MoviesRouterProtocol
    
    
    init(interface: MoviesViewProtocol, interactor: MoviesInteractorInputProtocol?, router: MoviesRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func setupView(with collection: UICollectionView, isSearchBarEmpty: Bool) {
        guard let movies = movies, let filteredMovies = filteredMovies else { return }
        let moviesToDataSource = isSearchBarEmpty ? movies : filteredMovies
        collectionViewDelegate = MoviesCollectionDelegate(self)
        collectionViewDatasource = MoviesCollectionDataSource(with: moviesToDataSource, collectionView: collection, delegate: collectionViewDelegate!)
    }
    
    func requestData() {
        guard let interactor = interactor else { return }
        interactor.requestDataToApi(page: numberOfPages)
    }
    
    func callCreateActivityIndicator() {
        guard let view = view else { return }
        view.createActivityIndicator()
    }
    
    func setAnimation(to: Bool) {
        guard let view = view else { return }
        view.changeIsAnimating(to: to)
    }
    
    func callSetupSearchController() {
        guard let view = view else { return }
        view.setupSearchController()
    }
    
    func filterMovies(using text: String) {
        isSearching = text != "" ? true : false
        guard let movies = movies else { return }
        filteredMovies = movies.filter { (movie: Movie) -> Bool in
            return movie.title.lowercased().contains(text.lowercased())
        }
        
        guard let filteredMovies = filteredMovies, let view = view else { return }
        if filteredMovies.isEmpty && text != "" {
            view.showResultImage(isHidden: false, text: text)
        } else {
            view.showResultImage(isHidden: true, text: text)
        }
        view.reloadCollectionView()
    }
}

//MARK: - MoviesInteractorOutputProtocol
extension MoviesPresenter: MoviesInteractorOutputProtocol {
    func sendMoreData(movies: [Movie]) {
        print(numberOfPages)
        guard let allMovies = self.movies else { return }
        if !allMovies.isEmpty {
            self.movies! += movies
        }
        
        guard let view = view else { return }
        view.changeIsAnimating(to: false)
        view.requestCollectionSetup()
        fetchingMore = false
    }
    
    func sendData(movies: [Movie]) {
        self.movies = movies
        guard let view = view else { return }
        view.requestCollectionSetup()
    }
}

//MARK: - MoviesDelegate
extension MoviesPresenter: MoviesDelegate {
    func fetchMoreMovies() {
        if !fetchingMore && !isSearching {
            fetchingMore = true
            numberOfPages += 1
            guard let view = view else { return }
            view.changeIsAnimating(to: true)
            requestData()
        }
    }
    
    func didSelectMovie(at: IndexPath) {
        guard let movies = movies else { return }
        router.showDetails(of: movies[at.row])
    }
}
