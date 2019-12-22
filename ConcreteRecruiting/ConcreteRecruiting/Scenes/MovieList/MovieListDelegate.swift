//
//  MovieListDelegate.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 22/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import UIKit

class MovieListDelegate: NSObject, UICollectionViewDelegateFlowLayout {
 
    var itemsPerRow: CGFloat = 2
    var spacing: CGFloat = 16
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // -Mark: FlowLayout delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let blankSpace = (spacing*2) + ((itemsPerRow-1)*spacing)
        
        let width = (collectionView.bounds.width - blankSpace) / itemsPerRow
        let height = width * 1.1
        
        let size = CGSize(width: width, height: height)
        
        return size
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
}
