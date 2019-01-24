//
//  UICollectionView+Extensions.swift
//  Movs
//
//  Created by Filipe Jordão on 23/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension UICollectionView {
    func isNearBottom() -> Observable<Bool> {
        return self.rx.contentOffset
                      .map(isNearBottom)
                      .distinctUntilChanged()
    }

    private func isNearBottom(point: CGPoint) -> Bool {
        return point.y + self.frame.size.height + 20 > self.contentSize.height
    }
}
