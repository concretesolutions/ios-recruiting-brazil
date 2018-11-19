//
//  FavouriteMoviesViewController.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit

class FavouriteMoviesViewController: UIViewController {

    let interface = FavouriteMoviesTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = interface
    }

}
