//
//  ItemCollectionViewCell.swift
//  theMovie-app
//
//  Created by Adriel Alves on 17/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import UIKit
import Kingfisher

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var uiMoviePoster: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var uiFavorite: UIImageView!
    
    private var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepare(with movie: MovieViewModel) {
        //uiMoviePoster.load(url: movie.posterPath!)
        if let urlImage = movie.posterPath {
            uiMoviePoster.kf.indicatorType = .activity
            uiMoviePoster.kf.setImage(with: urlImage)
        } else {
            uiMoviePoster.image = UIImage.init(named: "images")
        }
        lbMovieTitle.text = movie.title
        uiFavorite.image = movie.favoriteButtonImage
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lbMovieTitle.text = ""
        uiMoviePoster.image = UIImage.init(named: "images")
        
    }
    
    func setupCollectionViewItemSize(with collectionView: UICollectionView) {
        let itemsPerRow: CGFloat = 2
        let lineSpacing: CGFloat = 3
        let interItemSpacing: CGFloat = 1
        
        let width = (collectionView.frame.width - (itemsPerRow - 1) * interItemSpacing) / itemsPerRow
        let height = width * 1.5
        
        collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = lineSpacing
        collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
        
        collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
    }
}
