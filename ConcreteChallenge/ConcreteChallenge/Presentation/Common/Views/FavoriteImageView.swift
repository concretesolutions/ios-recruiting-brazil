//
//  FavoriteImageView.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

enum FavoriteState: String {
    case faved, unfaved
    
    var image: UIImage {
        return UIImage(named: self.rawValue)!
    }
}

class FavoriteImageView: UIImageView {
    var isFaved: Bool = false {
        didSet {
            if isFaved {
                self.image = self.imagesForState[.faved] ?? nil
            } else {
                self.image = self.imagesForState[.unfaved] ?? nil
            }
        }
    }
    
    private let imagesForState: [FavoriteState: UIImage?]
    
    var favoriteButtonTapCompletion: (() -> Void)?
    
    init(imagesForState: [FavoriteState: UIImage?]) {
        self.imagesForState = imagesForState
        super.init(image: imagesForState[.unfaved] ?? nil)
        
        self.contentMode = .scaleAspectFit
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favoriteButtonWasTapped)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func favoriteButtonWasTapped() {
        favoriteButtonTapCompletion?()
    }
}
