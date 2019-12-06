//
//  PopularMovieCellDelegate.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 06/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit

protocol PopularMovieCellDelegate: class {

    // MARK: - Tap handlers

    func didClickOnHeart(movieID: Int)
}
