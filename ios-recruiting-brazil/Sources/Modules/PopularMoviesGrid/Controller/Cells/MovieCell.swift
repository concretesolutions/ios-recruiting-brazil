//
//  MovieCell.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import UIKit

final class MovieCell: UICollectionViewCell {
    
    // MARK: Private Variables
    private var viewModel: PopularMoviesCellViewModelType!
    
    // MARK: IBOutlet
    @IBOutlet private weak var img: UIImageView!
    @IBOutlet private weak var lbMovieName: UILabel!
    
    func configuration(viewModel: PopularMoviesCellViewModelType) {
        self.viewModel = viewModel
        self.lbMovieName.text = viewModel.title
        self.img.loadImage(url: viewModel.imgUrl)
    }
}
