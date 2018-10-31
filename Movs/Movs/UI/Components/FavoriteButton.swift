//
//  FavoriteButton.swift
//  Movs
//
//  Created by Gabriel Reynoso on 30/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class FavoriteButton: UIButton {
    
    typealias Callback = (_ sender:FavoriteButton) -> Void
    
    var onFavorite:Callback?
    var onUnfavorite:Callback?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.setTitle(nil, for: .normal)
        self.setTitle(nil, for: .selected)
        self.setImage(Assets.favoriteGrayIcon.image, for: .normal)
        self.setImage(Assets.favoriteFillIcon.image, for: .selected)
        self.addTarget(self, action: #selector(buttonTapSelector), for: .touchUpInside)
    }
    
    @objc private func buttonTapSelector() {
        if self.isSelected {
            self.onFavorite?(self)
        } else {
            self.onUnfavorite?(self)
        }
        self.isSelected = !self.isSelected
    }
}
