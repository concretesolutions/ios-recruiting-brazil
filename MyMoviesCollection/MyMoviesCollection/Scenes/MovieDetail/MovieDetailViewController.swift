//
//  MovieDetailViewController.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 13/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var infosView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        setUpView()
    }
    
    private func setUpView() {
        view.addSubview(imageView)
        view.addSubview(infosView)
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        imageView.backgroundColor = .purple
        
        infosView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 1).isActive = true
        infosView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        infosView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        infosView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        infosView.backgroundColor = .black
        
    }
    
}
