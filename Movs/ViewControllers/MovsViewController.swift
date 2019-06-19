//
//  MovsViewController.swift
//  Movs
//
//  Created by Filipe on 17/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class MovsViewController: UIViewController {
// MARK: - Properties
    @IBOutlet weak var movCollectionView: UICollectionView!
    private let reuseIdentifier = "mcell"
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 5.0, right: 10.0)
    private let itemsPerRow: CGFloat = 2
    let numOfSects = 2
    var movies = [String]()
    
// MARK: - Main ViewController Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        movCollectionView.dataSource = self
        movCollectionView.delegate = self
    }

}

// MARK: - UICollectionViewDataSource
extension MovsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let numOfMovs = movies.count
        if (numOfMovs > 0) {
            if (numOfMovs % 2 == 0) {
                return (numOfMovs / 2)
            } else{
                return ((numOfMovs + 1) / 2)
            }
        }else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfSects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovsCollectionViewCell
        cell.backgroundColor = .black
        if (movies.count > 0) {
            if (indexPath.row == 0) {
                cell.titleLabel.text = movies[(indexPath.section * 2)]
            } else{
                cell.titleLabel.text = movies[((indexPath.section * 2) + 1)]
            }
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MovsViewController: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: (widthPerItem * 1.5))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}
