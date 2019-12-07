//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

//MARK: Router -
protocol MoviesRouterProtocol: class {
    func showDetails(of movie: Movie)
}

final class MoviesRouter: MoviesRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = MoviesViewController(nibName: nil, bundle: nil)
        let interactor = MoviesInteractor()
        let router = MoviesRouter()
        let presenter = MoviesPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func showDetails(of movie: Movie) {
        guard let moviesView = viewController, let navigationController = moviesView.navigationController else { return }
        let movieDetailsVC = MovieDetailsRouter.createModule(movie: movie)
        navigationController.pushViewController(movieDetailsVC, animated: true)
    }
}
