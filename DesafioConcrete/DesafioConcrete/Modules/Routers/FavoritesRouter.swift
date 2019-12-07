//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

//MARK: Router -
protocol FavoritesRouterProtocol: class {

}

final class FavoritesRouter: FavoritesRouterProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = FavoritesViewController(nibName: nil, bundle: nil)
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()
        let presenter = FavoritesPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
