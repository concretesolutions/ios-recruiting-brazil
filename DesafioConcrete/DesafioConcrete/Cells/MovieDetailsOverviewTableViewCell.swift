//
//  MovieDetailThirdSectionTableViewCell.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 05/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import UIKit

final class MovieDetailsOverviewTableViewCell: UITableViewCell {

    static func fileName() -> String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: fileName(), bundle: nil)
    }
    
    static func identifier() -> String {
        return "movieOverviewCell"
    }
    
    @IBOutlet weak var txtOverview: UILabel!
    
    func setup(with item: Movie) {
        self.txtOverview.text = item.overview
    }
}
