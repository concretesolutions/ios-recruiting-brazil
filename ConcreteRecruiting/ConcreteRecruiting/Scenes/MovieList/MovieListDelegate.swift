//
//  MovieListDelegate.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 22/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import UIKit

class MovieListDelegate: NSObject, UICollectionViewDelegateFlowLayout {
 
    let viewModel: MovieListViewModel
    
    var mode: DisplayMethod = .grid
    
    init(with viewModel: MovieListViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.didSelect(at: indexPath)
    }
    
    // -Mark: FlowLayout delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let blankSpace = (self.mode.spacing*2) + ((self.mode.itemsPerRow-1)*self.mode.spacing)
        
        let width = (collectionView.bounds.width - blankSpace) / self.mode.itemsPerRow
        let height = width * 1.6
        
        let size = CGSize(width: width, height: height)
        
        return size
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.mode.spacing, left: self.mode.spacing, bottom: self.mode.spacing, right: self.mode.spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.mode.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.mode.spacing
    }
    
}
enum DisplayMethod {
    
    case list
    case grid
    
    var itemsPerRow: CGFloat {
        switch self {
        case .grid:
            return 2
        case .list:
            return 1
        }
    }
    var spacing: CGFloat {
        return 16
    }
    
}
