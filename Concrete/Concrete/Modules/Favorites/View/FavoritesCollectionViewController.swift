//
//  FavoritesCollectionViewController.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 25/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit


class FavoritesCollectionViewController: UICollectionViewController {

    // MARK: - Properties
    // MARK: Private
    // MARK: Public
    var presenter:FavoritesPresenter!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favorites"
        
        
        self.presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.presenter.viewWillAppear()
    }
    
    // MARK: - Functions
    // MARK: Private
    private func view(with image:UIImage, and message:String) -> UIView {
        let theView = UIView(frame: self.view.frame)
        theView.translatesAutoresizingMaskIntoConstraints = false
        theView.backgroundColor = .white
        theView.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        theView.heightAnchor.constraint(equalToConstant: self.view.bounds.height).isActive = true
        
        let theUIImageView = UIImageView(frame: CGRect.zero)
        theUIImageView.image = image
        
        let theLabel = UILabel(frame: CGRect.zero)
        theLabel.text = message
        theLabel.textAlignment = .center
        
        let theStackView = UIStackView(arrangedSubviews: [theUIImageView,theLabel])
        theStackView.translatesAutoresizingMaskIntoConstraints = false
        theStackView.axis = .vertical
        theStackView.distribution = .equalSpacing
        theStackView.alignment = .fill
        theStackView.spacing = 8
        
        //
        theView.addSubview(theStackView)
        
        // - Constraints
        
        //UIImageView
        theUIImageView.heightAnchor.constraint(equalTo: theView.heightAnchor, multiplier: 0.3).isActive = true
        theUIImageView.widthAnchor.constraint(equalTo: theUIImageView.heightAnchor, multiplier: 1.0).isActive = true
        
        //UILabel
        theStackView.centerYAnchor.constraint(equalTo: theView.centerYAnchor).isActive = true
        theStackView.centerXAnchor.constraint(equalTo: theView.centerXAnchor).isActive = true
        
        //
        return theView
    }
    
    // MARK: Public
    
    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.presenter.numberOfSections(in: collectionView)
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.presenter.collectionView(collectionView, numberOfItemsInSection: section)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.presenter.collectionView(collectionView, cellForItemAt: indexPath)
        
    
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.collectionView(collectionView, didSelectItemAt: indexPath)
    }
}

extension FavoritesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = self.view.bounds
        
        return CGSize(width: bounds.width*0.425, height: bounds.height*0.35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        let bounds = self.view.bounds.width
        
        return bounds*0.025
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let bounds = self.view.bounds.width
        let spacing = bounds*0.05
        
        return UIEdgeInsets(top: spacing,
                            left: spacing,
                            bottom: spacing,
                            right: spacing)
    }
}
