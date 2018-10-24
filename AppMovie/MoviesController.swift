//
//  ViewController.swift
//  AppMovie
//
//  Created by Renan Alves on 21/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class MoviesController: UIViewController{

    var movies = [NSDictionary]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    let dataSourceCv = MoviesCollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donwloadMovies()
    }
    
    private func donwloadMovies() {
        MovieDAO.shared.requestMovies(completion: { (moviesJSON) in
            if let _movies = moviesJSON {
                self.movies = _movies
                self.setuCollectionView()
            } else {
                print("Nothing movies")
            }
        })
    }
    
    private func setuCollectionView() {
        collectionView.dataSource = dataSourceCv
        dataSourceCv.datas = movies
    }
}

