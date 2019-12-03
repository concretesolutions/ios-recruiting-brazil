//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

//MARK: View -
protocol FavoritesViewProtocol: class {

    var presenter: FavoritesPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}

//MARK: Presenter -
protocol FavoritesPresenterProtocol: class {

    var interactor: FavoritesInteractorInputProtocol? { get set }
}

final class FavoritesPresenter: FavoritesPresenterProtocol {

    weak private var view: FavoritesViewProtocol?
    var interactor: FavoritesInteractorInputProtocol?
    private let router: FavoritesRouterProtocol

    init(interface: FavoritesViewProtocol, interactor: FavoritesInteractorInputProtocol?, router: FavoritesRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}

extension FavoritesPresenter: FavoritesInteractorOutputProtocol {
    
}
