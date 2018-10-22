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

final class MovieDetailViewController: MVPBaseViewController, MovieDetailPresenterView {
    
    var presenter: MovieDetailViewPresenter? {
        get {
            return self.basePresenter as? MovieDetailViewPresenter
        }
        set {
            self.basePresenter = newValue
        }
    }
}
