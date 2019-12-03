//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

//MARK: Interactor -
protocol FavoritesInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol FavoritesInteractorInputProtocol: class {

    var presenter: FavoritesInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

final class FavoritesInteractor: FavoritesInteractorInputProtocol {

    weak var presenter: FavoritesInteractorOutputProtocol?
}
