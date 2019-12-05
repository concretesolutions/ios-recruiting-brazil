//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

//MARK: View -
protocol MoviesViewProtocol: class {

    var presenter: MoviesPresenterProtocol?  { get set }

    func requestCollectionSetup()
    /* Presenter -> ViewController */
}

//MARK: Presenter -
protocol MoviesPresenterProtocol: class {

    var interactor: MoviesInteractorInputProtocol? { get set }
    var collectionViewDatasource: MoviesCollectionDataSource? { get set }
    var collectionViewDelegate: MoviesCollectionDelegate? { get set }
    var movies: [Movie]? { get set }
    
    func setupView(with collection: UICollectionView)
    func requestData()
    /* ViewController -> Presenter */
}

final class MoviesPresenter: MoviesPresenterProtocol {
    
    var collectionViewDatasource: MoviesCollectionDataSource?
    var collectionViewDelegate: MoviesCollectionDelegate?
    var movies: [Movie]?
    
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
        collectionViewDatasource = MoviesCollectionDataSource(items: movies, collectionView: collection, delegate: collectionViewDelegate!)
    }
    
    func requestData() {
        guard let interactor = interactor else { return }
        interactor.requestDataToApi()
    }
}

//MARK: - MoviesInteractorOutputProtocol
extension MoviesPresenter: MoviesInteractorOutputProtocol {
    func sendData(movies: [Movie]) {
        self.movies = movies
        guard let view = view else { return }
        view.requestCollectionSetup()
    }
}

 //MARK: - MoviesDelegate
extension MoviesPresenter: MoviesDelegate {
    func didSelectMovie(at: IndexPath) {
        print("Ola")
    }
}
