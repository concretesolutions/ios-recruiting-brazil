//
//  ModalPresenterDelegate.swift
//  Movs
//
//  Created by Gabriel D'Luca on 06/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

@objc protocol ModalPresenterDelegate: AnyObject {
    @objc optional func showFilters()
    @objc optional func showMovieDetails(movie: Movie)
}
