//
//  CollectionDelegate.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 22/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class CollectionDelegate: NSObject, UICollectionViewDelegate {
    
    var shownIndexes : [IndexPath] = []
    
    weak var cellDelegate: CellSelected?
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (!shownIndexes.contains(indexPath)) {
            shownIndexes.append(indexPath)
            
            cell.transform = CGAffineTransform(translationX: 0, y: 40)
            
            UIView.beginAnimations("rotation", context: nil)
            UIView.setAnimationDuration(0.5)
            cell.transform = CGAffineTransform.identity
            UIView.commitAnimations()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.2) {
            cell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.2) {
            cell?.transform = CGAffineTransform.identity
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MovieCollectionViewCell
        
        UIView.animate(withDuration: 0.2, animations: {
            cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (true) in
            UIView.animate(withDuration: 0.2, animations: {
                cell.transform = CGAffineTransform.identity
            }) { (true) in
                guard let film = cell.film else {
                    print("Selected cell don't have a film in: \(CollectionDelegate.self)")
                    return
                }
                self.cellDelegate?.goToDetalViewController(withFilm: film)
            }
        }
    }
}
