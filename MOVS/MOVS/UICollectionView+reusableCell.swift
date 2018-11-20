//
//  UICollectionView+reusableCell.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 16/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            print("Unable to get cell of type: \(T.self) in: \(self)")
            fatalError()
        }
        
        return cell
    }
    
    func dequeueReusableSupplementaryViewOfKind<T: UICollectionViewCell>(ofKind kind: String, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            print("Unable to get cell of type: \(T.self) in: \(self)")
            fatalError()
        }
        return cell
    }
    
    func register<T: UICollectionViewCell>(cellType: T){
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    
}
