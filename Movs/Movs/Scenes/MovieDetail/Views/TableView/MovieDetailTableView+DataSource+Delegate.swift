//
//  MovieDetailTableView+DataSource+Delegate.swift
//  Movs
//
//  Created by Ricardo Rachaus on 31/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

extension MovieDetailTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return titleCell
        case 1:
            return yearCell
        case 2:
            return genreCell
        default:
            return UITableViewCell()
        }
    }
    
    
}

extension MovieDetailTableView: UITableViewDelegate {
    
}
