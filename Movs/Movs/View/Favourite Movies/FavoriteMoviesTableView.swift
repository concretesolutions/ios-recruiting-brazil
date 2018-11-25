//
//  FavoriteMoviesViewTableView.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit

class FavoriteMoviesTableView: UITableView {

    //MARK: - Initializers
    override init(frame: CGRect = .zero, style: UITableView.Style = .plain) {
        super.init(frame: frame, style: style)
        setupDesing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setupDesing() {
        backgroundColor = Design.colors.white
        separatorStyle = .none
    }
    
}
