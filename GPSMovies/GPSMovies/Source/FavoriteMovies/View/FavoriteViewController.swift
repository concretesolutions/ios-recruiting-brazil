//
//  FavoriteViewController.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: OUTLETS
    
    // MARK: CONSTANTS
    
    // MARK: VARIABLES
    private var presenter: FavoritePresenter!
    private lazy var viewData:FavoriteViewData = FavoriteViewData()
    
    // MARK: IBACTIONS
}

//MARK: - LIFE CYCLE -
extension FavoriteViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = FavoritePresenter(viewDelegate: self)
    }
}

//MARK: - DELEGATE PRESENTER -
extension FavoriteViewController: FavoriteViewDelegate {

}

//MARK: - AUX METHODS -
extension FavoriteViewController {

}
