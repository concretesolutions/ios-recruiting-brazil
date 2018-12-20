//
//  MoviesGridViewController.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 20/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit

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

    let collectionView = MoviesGridCollectionView()
//    let collectionViewDataSource: MoviesGridCollectionDataSource?
    //FIXME:- create collection delegate and setup collection in willAppear
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MoviesGridViewController: CodeView{
    func buildViewHierarchy() {
        //
    }
    
    func setupConstraints() {
        //
    }
    
    func setupAdditionalConfiguration() {
        //
    }
    
    func setupView() {
        //
    }
    
    
}
