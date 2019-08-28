//
//  ViewController.swift
//  MovieApp
//
//  Created by Mac Pro on 26/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var controller = MovieController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        
        controller.getMoviesAPI { (sucesso) in
            if sucesso {
                self.collectionView.reloadData()
                print("Sucesso")
            }else{
                print("Deu ruim")
            }
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller.arrayMovieDB.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as? HomeCell{
            
           cell.setCell(movie: controller.arrayMovieDB[indexPath.item])
           return cell
        }
    
        return UICollectionViewCell()
    }
    
    
    
}

extension HomeViewController: UICollectionViewDelegate{
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = (collectionView.frame.width / 2) * 1.5 + 60
        return CGSize(width: collectionView.frame.width / 2, height: height)
    }
    
}
