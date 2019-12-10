//
//  FavoritesTableView.swift
//  Movs
//
//  Created by Lucca Ferreira on 03/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit

class FavoritesTableView: UITableView {

    required init() {
        super.init(frame: .zero, style: .plain)
        self.delegate = self
        self.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "favoritesTableViewCell")
        self.separatorStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension FavoritesTableView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }

}
