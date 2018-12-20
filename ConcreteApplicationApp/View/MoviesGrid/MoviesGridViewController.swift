//
//  MoviesGridViewController.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 20/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import SnapKit

//FIXME:- change protocol file
protocol CodeView{
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView{
    func setupView(){
         buildViewHierarchy()
         setupConstraints()
         setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration() {}
    
}

class MoviesGridViewController: UIViewController {

    //CollectionView
    let collectionView = MoviesGridCollectionView()
    var collectionViewDataSource: MoviesGridCollectionDataSource?
    var collectionViewDelegate: MoviesGridCollectionDelegate?
    //FIXME:- create collection delegate and setup collection in willAppear
    //TMDB API
    let tmdb = TMDBManager()
    //Properties
    var movies:[Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        tmdb.getPopularMovies(page: 1) { (result) in
            switch result{
            case .success(let movies):
                self.handleFetchOf(movies: movies)
            case .error:
            print("error")
            //FIXME:- display error
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func handleFetchOf(movies:[Movie]){
        self.setupCollectionView(with: movies)
    }
    
    
    func setupCollectionView(with movies: [Movie]){
        
        self.collectionView.isHidden = false
        collectionViewDataSource = MoviesGridCollectionDataSource(movies: movies, collectionView: self.collectionView)
        self.collectionView.dataSource = collectionViewDataSource
        collectionViewDelegate = MoviesGridCollectionDelegate(movies: movies)
        self.collectionView.delegate = collectionViewDelegate
        self.collectionView.reloadData()
        
    }
    
}


extension MoviesGridViewController: CodeView{
    func buildViewHierarchy() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        //
    }
    
}
