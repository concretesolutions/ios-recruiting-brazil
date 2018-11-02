//
//  MovieDetailsViewController+UITableViewDelegate.swift
//  Mov
//
//  Created by Miguel Nery on 01/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

extension MovieDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.row != 3 else { return MovieDetailsTableView.overviewCellHeight }
        
        return MovieDetailsTableView.cellHeight
    }
}
