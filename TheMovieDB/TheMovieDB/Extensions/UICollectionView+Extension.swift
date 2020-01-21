//
//  UICollectionView+Extension.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 19/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import UIKit

extension UICollectionView {
    public func addEmptyState(state: EmptyState) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            let emptyView = EmptyView.init()
            emptyView.changeEmptyView(toState: state)
            self.backgroundView = emptyView
        }
    }
}
