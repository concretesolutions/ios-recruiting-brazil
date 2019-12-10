//
//  CellFavorite.swift
//  RecruitingChallenge
//
//  Created by Giovane Barreira on 12/8/19.
//  Copyright © 2019 Giovane Barreira. All rights reserved.
//

import UIKit

protocol CellDelegate: class {
    func didTap(_ cell: FavoriteCell, favoriteTapped: Bool)
}

class FavoriteCell: UITableViewCell {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var btnImage: UIButton!
    
    let favoriteOff = UIImage(named: "favorite_full_icon")
    let favoriteOn = UIImage(named: "favorite_gray_icon")
    var favoriteIsSet: Bool = false
    weak var delegate: CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
  
    @IBAction func setFavorite(_ sender: Any) {
        if favoriteIsSet {
            delegate?.didTap(self, favoriteTapped: false)
            btnImage.setBackgroundImage(favoriteOn, for: .normal)
            favoriteIsSet = false
        } else {
            delegate?.didTap(self, favoriteTapped: true)
            btnImage.setBackgroundImage(favoriteOff, for: .normal)
            favoriteIsSet = true
        }
    }
}


