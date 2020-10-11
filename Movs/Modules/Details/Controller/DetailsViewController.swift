//
//  DetailsViewController.swift
//  Movs
//
//  Created by Joao Lucas on 10/10/20.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var movies: ResultMoviesDTO!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        
        print(movies.title)
    }
}
