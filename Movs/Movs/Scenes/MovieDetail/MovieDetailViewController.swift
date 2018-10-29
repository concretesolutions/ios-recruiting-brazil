//
//  MovieDetailViewController.swift
//  Movs
//
//  Created by Ricardo Rachaus on 28/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        print(movie)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        setupView()
    }
    
}

extension MovieDetailViewController: CodeView {
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupAdditionalConfiguration() {
        let view = UIView(frame: .zero)
        self.view = view
        view.backgroundColor = .white
    }
}
