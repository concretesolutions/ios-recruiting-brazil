//
//  MoviesCollectionDelegate.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import UIKit

final class MoviesCollectionDelegate: NSObject {
    
    let delegate: MoviesDelegate
    
    init(_ delegate: MoviesDelegate) {
        self.delegate = delegate
    }
}

extension MoviesCollectionDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didSelectMovie(at: indexPath)
    }
}

extension MoviesCollectionDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screen = UIScreen.main.bounds
        return CGSize(width: screen.width/2 - 20, height: screen.height/3)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
    }
}
