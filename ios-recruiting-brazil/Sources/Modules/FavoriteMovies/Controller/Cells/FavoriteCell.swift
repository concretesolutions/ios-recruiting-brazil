//
//  FavoriteCell.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import UIKit

final class FavoriteCell: UITableViewCell {
    
    @IBOutlet private weak var lbTitle: UILabel!
    @IBOutlet private weak var lbYear: UILabel!
    @IBOutlet private weak var lbDesc: UILabel!
    @IBOutlet private weak var imgPoster: UIImageView!
    
    func configuration(viewModel: FavoriteCellViewModelType) {
        self.lbTitle.text = viewModel.title
        self.lbYear.text = viewModel.year
        self.lbDesc.text = viewModel.desc
        self.imgPoster.loadImage(url: viewModel.imgURL)
    }
}
