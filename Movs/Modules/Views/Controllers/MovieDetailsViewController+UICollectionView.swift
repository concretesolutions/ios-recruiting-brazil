//
//  MovieDetailsViewController+UICollectionView.swift
//  Movs
//
//  Created by Gabriel D'Luca on 16/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

extension MovieDetailsViewController: UICollectionViewDelegate { }

extension MovieDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.genresNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as? GenreCollectionViewCell else {
            fatalError()
        }
        
        cell.nameLabel.text = self.viewModel.genresNames[indexPath.row]
        cell.nameLabel.textColor = UIColor.systemBackground
        cell.contentView.backgroundColor = UIColor(named: "palettePurple")
        return cell
    }
}

extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.viewModel.genresNames[indexPath.row].size(withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .bold)
        ])
        return CGSize(width: size.width + 24.0, height: size.height + 8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 24.0, bottom: 0.0, right: 24.0)
    }
}
