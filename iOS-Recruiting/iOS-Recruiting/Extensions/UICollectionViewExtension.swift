//
//  UICollectionViewExtension.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    enum ReusableViewKind {
        case header
        case footer
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        self.register(T.self, forCellWithReuseIdentifier: T.identifier)
    }

    func register<T: UICollectionReusableView>(_: T.Type, kind: ReusableViewKind) where T: ReusableView {
        switch kind {
        case .header:
            self.register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
        case .footer:
            self.register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.identifier)
        }
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        self.register(nib, forCellWithReuseIdentifier: T.identifier)
    }

    func register<T: UICollectionReusableView>(_: T.Type, kind: ReusableViewKind) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        switch kind {
        case .header:
            self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
        case .footer:
            self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.identifier)
        }
    }
    
    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }

    func dequeue<T: UICollectionReusableView>(for indexPath: IndexPath, kind: ReusableViewKind) -> T where T: ReusableView {
        switch kind {
        case .header:
            guard let cell = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
                fatalError("Could not dequeue cell with identifier: \(T.identifier)")
            }
            return cell
        case .footer:
            guard let cell = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
                fatalError("Could not dequeue cell with identifier: \(T.identifier)")
            }
            return cell
        }
    }
}
