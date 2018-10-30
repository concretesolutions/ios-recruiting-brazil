//
//  MovieGridListView.swift
//  Mov
//
//  Created by Miguel Nery on 29/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

protocol MovieGridListView where Self: UIView {
    func display(movies: [MovieGridViewModel])
}
