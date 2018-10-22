//
//  FavoriteMoviesViewController.swift
//  Movs
//
//  Created by Gabriel Reynoso on 21/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

protocol FavoriteMoveisViewPresenter: PresenterProtocol {
}

final class FavoriteMoviesViewController: MVPBaseViewController, FavoriteMoviesPresenterView {
    var presenter:FavoriteMoveisViewPresenter? {
        get {
            return self.basePresenter as? FavoriteMoveisViewPresenter
        }
        set {
            self.basePresenter = newValue
        }
    }
}
