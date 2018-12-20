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
