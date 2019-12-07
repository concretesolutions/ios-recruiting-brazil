//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

//MARK: Interactor -
protocol FavoritesInteractorOutputProtocol: class {
    
    func sendMovies(movies: [Movie])
    /* Interactor -> Presenter */
}

protocol FavoritesInteractorInputProtocol: class {
    
    var presenter: FavoritesInteractorOutputProtocol?  { get set }
    func requestMovies()
    func unfavorite(movie: Movie)
    /* Presenter -> Interactor */
}

final class FavoritesInteractor: FavoritesInteractorInputProtocol {
    
    weak var presenter: FavoritesInteractorOutputProtocol?
    
    func requestMovies() {
        let movies = DataManager.shared.getData()
        guard let presenter = presenter else { return }
        presenter.sendMovies(movies: movies)
    }
    
    func unfavorite(movie: Movie) {
        DataManager.shared.deleteData(movieId: movie.id)
    }
}
