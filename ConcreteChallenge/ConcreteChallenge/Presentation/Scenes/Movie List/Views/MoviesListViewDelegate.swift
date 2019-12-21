//
//  MoviesListViewDelegate.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol MoviesListViewDelegate: AnyObject {
    func needShowError(withMessage message: String, retryCompletion: (() -> Void))
}
