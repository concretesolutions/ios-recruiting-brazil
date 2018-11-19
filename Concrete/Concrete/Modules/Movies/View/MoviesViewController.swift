//
//  MoviesViewController.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 17/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

class MoviesViewController: UICollectionViewController {

    // MARK: - Outlets
    @IBOutlet var outletLoadingView: UIView!
    
    // MARK: - Properties
    // MARK: Private
    // MARK: Public
    var presenter: MoviesPresenter!
    
    var isLoading: Bool = false {
        didSet {
            self.set(isLoading: self.isLoading)
        }
    }
    
    // MARK: - UICollectionViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLayout()
        self.setupRefreshControl()
        
        self.presenter.viewDidLoad()
    }
    
    // MARK: - Functions
    // MARK: Private
    private func setupRefreshControl(){
        let refresh = UIRefreshControl()
        refresh.addTarget(self.presenter, action: #selector(MoviesPresenter.reload), for: .valueChanged)
        refresh.tintColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        self.collectionView?.refreshControl = refresh
    }
    
    private func setupLayout() {
        
    }
    
    private func set(isLoading:Bool) {
        if isLoading {
            self.collectionView?.backgroundView = self.outletLoadingView
        }else{
            self.collectionView?.backgroundView = nil
        }
    }
    
    // MARK: Public
    
    
    // MARK: - UICollectionDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.presenter.collectionView(collectionView, cellForItemAt: indexPath)
        
        return cell
    }
    
    // MARK: - UICollectionDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.collectionView(collectionView, didSelectItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.presenter.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let movieCell = cell as? MovieCollectionViewCell else {
            Logger.log(in: self, message: "Could not cast cell:\(cell) to MovieCollectionViewCell")
            return
        }
        
        movieCell.cleanData()
    }
}

// MARK: - UICollectionViewFlowLayout
extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    
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
