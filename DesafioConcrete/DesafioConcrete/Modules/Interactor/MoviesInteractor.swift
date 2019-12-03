//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

//MARK: Interactor -
protocol MoviesInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol MoviesInteractorInputProtocol: class {

    var presenter: MoviesInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

final class MoviesInteractor: MoviesInteractorInputProtocol {

    weak var presenter: MoviesInteractorOutputProtocol?
}
