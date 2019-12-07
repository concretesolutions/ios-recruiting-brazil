//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

//MARK: View -
protocol MoviesViewProtocol: class {
    
    var presenter: MoviesPresenterProtocol?  { get set }
    
    func requestCollectionSetup()
    func createActivityIndicator()
    func changeIsAnimating(to animation: Bool)
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
    
    func setupView(with collection: UICollectionView)
    func requestData()
    func callCreateActivityIndicator()
    func setAnimation(to: Bool)
    /* ViewController -> Presenter */
}

final class MoviesPresenter: MoviesPresenterProtocol {
    
    var collectionViewDatasource: MoviesCollectionDataSource?
    var collectionViewDelegate: MoviesCollectionDelegate?
    var movies: [Movie]?
    var numberOfPages: Int = 1
    var fetchingMore: Bool = false
    
    weak private var view: MoviesViewProtocol?
    var interactor: MoviesInteractorInputProtocol?
    private let router: MoviesRouterProtocol
    
    
    init(interface: MoviesViewProtocol, interactor: MoviesInteractorInputProtocol?, router: MoviesRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func setupView(with collection: UICollectionView) {
        guard let movies = movies else { return }
        self.setupCollectionView(with: collection, using: movies)
    }
    
    func setupCollectionView(with collection: UICollectionView, using movies: [Movie]) {
        collectionViewDelegate = MoviesCollectionDelegate(self)
        collectionViewDatasource = MoviesCollectionDataSource(with: movies, collectionView: collection, delegate: collectionViewDelegate!)
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
        if !fetchingMore {
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
