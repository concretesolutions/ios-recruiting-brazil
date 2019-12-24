//
//  FavoritesTableView.swift
//  Movs
//
//  Created by Lucca Ferreira on 03/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit

class FavoritesTableView: UITableView {
    
    var state: ExceptionView.State = .none {
        didSet {
            let exceptionView = ExceptionView(frame: .zero)
            exceptionView.state = self.state
            self.backgroundView = exceptionView
        }
    }

    required init() {
        super.init(frame: .zero, style: .plain)
        self.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "favoritesTableViewCell")
        self.separatorStyle = .none
        self.rowHeight = 168.0
        self.allowsSelection = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
