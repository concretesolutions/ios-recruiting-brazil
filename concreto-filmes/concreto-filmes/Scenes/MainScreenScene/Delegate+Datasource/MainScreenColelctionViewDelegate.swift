//
//  MainScreenColelctionViewDelegate.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 27/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import UIKit

extension MainScreenViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isFiltering {
            router?.routeToMovieDetail(shouldFilter: true, index: indexPath.item)
        } else {
            router?.routeToMovieDetail(shouldFilter: false, index: indexPath.item)
        }
    }
}
