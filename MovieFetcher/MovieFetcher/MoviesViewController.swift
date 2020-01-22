//
//  MoviesViewController.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 22/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        safeArea = view.layoutMarginsGuide
        setContraints()
        // Do any additional setup after loading the view.
    }
    
    var safeArea:UILayoutGuide!
    
    
    lazy var collectionView:UICollectionView = {
        
        //gridView
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = CGFloat(16)
        flowLayout.minimumInteritemSpacing = CGFloat(16)
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        //delegates
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //cell setup
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        return collectionView
        
    }()
    
    func setContraints(){
        
        collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo:safeArea.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    
}


extension MoviesViewController:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath)
        return cell
        
    }
    
    
}

