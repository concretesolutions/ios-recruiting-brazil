//
//  FavoritesTableView.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

class FavoritesTableView: UITableView {
    
    static let cellReuseIdentifier = "FavoritesCell"
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableView.cellReuseIdentifier)
    }
    
}
