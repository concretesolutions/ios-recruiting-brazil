//
//  FavoritesTableViewDelegate.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 01/11/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import UIKit

extension FavoritesViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToMovieDetail(shouldFilter: false, index: indexPath.item)
    }
}
