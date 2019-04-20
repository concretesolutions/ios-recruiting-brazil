//
//  GenresViewController.swift
//  movs
//
//  Created by Lorien Moisyn on 20/04/19.
//  Copyright © 2019 Auspex. All rights reserved.
//

import Foundation

class GenresViewController: FilterViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getGenres()
    }
    
}
