//  Created Gustavo Garcia Leite on 05/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

//MARK: Interactor -
protocol MovieDetailsInteractorOutputProtocol: class {

    func sendGenres(genres: [Genre])
    /* Interactor -> Presenter */
}

protocol MovieDetailsInteractorInputProtocol: class {

    var presenter: MovieDetailsInteractorOutputProtocol?  { get set }

    func requestGenres()
    
    /* Presenter -> Interactor */
}

final class MovieDetailsInteractor: MovieDetailsInteractorInputProtocol {

    weak var presenter: MovieDetailsInteractorOutputProtocol?
    
    func requestGenres() {
        ApiManager.getGenres(success: { data in
            do {
                let root = try JSONDecoder().decode(GenreRoot.self, from: data)
                guard let presenter = self.presenter else { return }
                presenter.sendGenres(genres: root.genres)
            } catch let error as NSError {
                print(error)
            }
        }) { (error) in
            print(error)
        }
    }
}
