//
//  ViewController.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 10/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class MoviesView: UIViewController {
    
    // MARK: - VIPER
    var presenter: MoviesPresenter!
    
    // MARK: - Outlets
    @IBOutlet weak var outletMoviesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.outletMoviesCollection.delegate = self
        self.outletMoviesCollection.dataSource = self.presenter //self.presenter.interactor
        
        // VIPER
        self.presenter.didLoad()
    }
    
    func showPopularMovies() {
        self.outletMoviesCollection.reloadData()
    }
    
}
