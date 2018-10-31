//
//  MovieDetailViewController.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

protocol MovieDetailViewPresenter: PresenterProtocol {
}

final class MovieDetailViewController: MVPBaseViewController {
    
    private var movieDetail:MovieDetail! {
        didSet {
            self.movieDetail.setupView()
            self.view = self.movieDetail
        }
    }
    
    
    
    var presenter: MovieDetailViewPresenter? {
        get {
            return self.basePresenter as? MovieDetailViewPresenter
        }
        set {
            self.basePresenter = newValue
        }
    }
}

extension MovieDetailViewController: MovieDetailPresenterView {
    
    func setupOnce() {
        self.title = "Movie"
        //TODO: create movie detail view
    }
}
