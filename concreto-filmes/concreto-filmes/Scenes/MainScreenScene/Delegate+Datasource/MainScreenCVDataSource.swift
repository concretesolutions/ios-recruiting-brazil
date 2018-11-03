//
//  MainScreenCVDataSource.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 25/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import UIKit

extension MainScreenViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedMovies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.movieCellID, for: indexPath) as? MainScreenMovieCell else {
            return UICollectionViewCell()
        }
        let item = displayedMovies[indexPath.item]
        cell.setData(data: item)
        cell.accessibilityIdentifier = item.title
        return cell
    }
}
