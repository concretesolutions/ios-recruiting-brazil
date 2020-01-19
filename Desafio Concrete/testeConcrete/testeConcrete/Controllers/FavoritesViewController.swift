//
//  FavoritesViewController.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 15/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    var chooseFavorite:[String:Int] = [:]
}
extension FavoritesViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        print(chooseFavorite.count);
    }
}
