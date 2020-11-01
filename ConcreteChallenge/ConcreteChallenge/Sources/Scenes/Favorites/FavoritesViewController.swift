//
//  FavoritesViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

protocol FavoritesDisplayLogic: AnyObject { }

final class FavoritesViewController: UIViewController, FavoritesDisplayLogic {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
}
