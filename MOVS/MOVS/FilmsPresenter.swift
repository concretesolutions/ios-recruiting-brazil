//
//  FilmsPresenter.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 15/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilmsPresenter: NSObject{
    // MARK: - Variables
    // MARK: Private
    private var collectionDataSource: FilmsDataSource!
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
    func viewDidLoad(withCollection collection: UICollectionView) {
        self.collectionDataSource = FilmsDataSource(withCollection: collection)
        collection.dataSource = self.collectionDataSource
    }
}
