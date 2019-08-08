//
//  MoviesCollectionViewController.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 08/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import UIKit

class MoviesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let cellSpacing: CGFloat = 12.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        self.collectionView.collectionViewLayout = layout
    }
}

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var favorite: UIImageView!
    
    
    func initTitleView() {
        self.titleView.backgroundColor = UIColor.clear
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.titleView.frame
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.7)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.locations = [0.0, 0.2, 0.6, 1.0]
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.0).cgColor,
            UIColor.black.withAlphaComponent(0.3).cgColor,
            UIColor.black.withAlphaComponent(0.7).cgColor,
            UIColor.black.cgColor]
        
        self.titleView.layer.insertSublayer(gradientLayer, at: 0)
    }
}

//DelegateFlowLayout
extension MoviesCollectionViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let movieCellWidth = (collectionView.frame.width / 2) - (cellSpacing * 1.5)
        return CGSize(width: movieCellWidth, height: movieCellWidth)
    }
}

// DataSource
extension MoviesCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        movieCell.initTitleView()
        movieCell.favorite.image = [UIImage(named: "Favorite"), UIImage(named: "Favorite"), UIImage(named: "FavoriteFilled")].randomElement() as! UIImage
        movieCell.cover.backgroundColor = [UIColor.green, UIColor.red, UIColor.blue, UIColor.gray].randomElement()
        return movieCell
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
