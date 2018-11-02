//
//  MoviesGridPresenter.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

protocol MoviesGridPresenterView: ViewProtocol {
    func presentLoading()
    func present(movies:[Movie])
    func presentError()
}

final class MoviesGridPresenter: MVPBasePresenter {
    
    private let operation = FetchMoviesOperation()
    
    var view:MoviesGridPresenterView? {
        return self.baseView as? MoviesGridPresenterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.operation.onError = { [unowned self] err in
            self.view?.presentError()
        }
        
        self.operation.onSuccess = { [unowned self] movs in
            self.view?.present(movies: movs)
        }
        
        self.operation.perform()
        self.view?.presentLoading()
    }
}

extension MoviesGridPresenter: MoviesGridViewPresenter {
    
}
