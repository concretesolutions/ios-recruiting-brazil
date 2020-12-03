//
//  FavoritosTabViewController+UITabBarDelegate.swift
//  Movs
//
//  Created by Gabriel Coutinho on 03/12/20.
//

import Foundation
import UIKit

extension FavoritosTabViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabelaFilmes.reloadData()
    }
}
