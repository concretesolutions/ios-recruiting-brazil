//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

//MARK: Interactor -
protocol MoviesInteractorOutputProtocol: class {
    
    /* Interactor -> Presenter */
    func sendData(movies: [Movie])
    func sendMoreData(movies: [Movie])
}

protocol MoviesInteractorInputProtocol: class {
    
    var presenter: MoviesInteractorOutputProtocol?  { get set }
    
    func requestDataToApi(page: Int)
    /* Presenter -> Interactor */
}

final class MoviesInteractor: MoviesInteractorInputProtocol {
    
    weak var presenter: MoviesInteractorOutputProtocol?
    
    func requestDataToApi(page: Int) {
        ApiManager.getMovies(page: page, success: { data in
            do {
                let root = try JSONDecoder().decode(MovieRoot.self, from: data)
                guard let presenter = self.presenter else { return }
                if page > 1 {
                    presenter.sendMoreData(movies: root.results)
                } else {
                    presenter.sendData(movies: root.results)
                }
            } catch let error as NSError {
                print(error)
            }
        }) { (error) in
            print(error)
        }
    }
}
