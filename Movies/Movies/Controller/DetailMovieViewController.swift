//
//  DetailMovieViewController.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {
    
    var movie:Movie?

    private unowned var detailMovieView: DetailMovieView{ return self.view as! DetailMovieView }
    
    override func loadView() {
        self.view = DetailMovieView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
