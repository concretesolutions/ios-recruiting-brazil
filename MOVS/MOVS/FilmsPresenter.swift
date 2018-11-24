//
//  FilmsPresenter.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 15/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilmsPresenter: NSObject, CellSelected{
    
    // MARK: - Variables
    // MARK: Private
    private var collectionDataSource: CollectionDataSource?
    private var collectionDelegate: CollectionDelegate?
    
    // MARK: Public
    var router:FilmsRouter
    var interactor:FilmsInteractor
    var view:FilmsView
    
    // MARK: - Initializers
    init(router:FilmsRouter, interactor:FilmsInteractor, view:FilmsView) {
        self.router = router
        self.interactor = interactor
        self.view = view
        super.init()
        self.view.presenter = self
        
    }
    
    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func viewDidLoad(withCollection collection: UICollectionView, andSearchController searchController: UISearchController) {
        self.collectionDataSource = CollectionDataSource(withCollection: collection, andSearchController: searchController)
        collection.dataSource = self.collectionDataSource
        self.collectionDelegate = CollectionDelegate()
        self.collectionDelegate?.cellDelegate = self
        collection.delegate = self.collectionDelegate
    }
    
    func viewWillAppear(){
        self.collectionDataSource?.collection.reloadData()
    }
    
    func goToDetalViewController(withFilm film: ResponseFilm) {
        self.router.goToFilmDetail(withFilm: film)
    }
    
}
