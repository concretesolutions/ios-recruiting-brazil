//
//  MovieCellDelegate.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 15/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
protocol MovieCellDelegate: AnyObject {
    func didFavoriteMovie(movie: MovieDTO, withImage image: UIImage?)
}
