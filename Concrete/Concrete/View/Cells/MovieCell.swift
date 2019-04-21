//
//  MovieCell.swift
//  Concrete
//
//  Created by Vinicius Brito on 20/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var labelTitle: UILabel!

    func setCellData(cellData: MovieViewModel) {
        labelTitle.text = ""

        if let title = cellData.title {
            labelTitle.text = title
        }
    }
}
