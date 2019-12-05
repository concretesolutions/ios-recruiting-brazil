//  Created Gustavo Garcia Leite on 05/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

//MARK: Router -
protocol MovieDetailsRouterProtocol: class {

}

final class MovieDetailsRouter: MovieDetailsRouterProtocol {

    weak var viewController: UIViewController?

    static func createModule(movie: Movie) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = MovieDetailsViewController(nibName: nil, bundle: nil)
        let interactor = MovieDetailsInteractor()
        let router = MovieDetailsRouter()
        let presenter = MovieDetailsPresenter(interface: view, interactor: interactor, router: router)

        presenter.movie = movie
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
