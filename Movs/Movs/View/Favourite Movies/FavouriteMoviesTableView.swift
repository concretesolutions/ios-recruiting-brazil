//
//  FavouriteMoviesViewTableView.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit

class FavouriteMoviesTableView: UITableView {

    override init(frame: CGRect = .zero, style: UITableView.Style = .plain) {
        super.init(frame: frame, style: style)
        setupDesing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDesing() {
        backgroundColor = Design.colors.white
    }
    
}
