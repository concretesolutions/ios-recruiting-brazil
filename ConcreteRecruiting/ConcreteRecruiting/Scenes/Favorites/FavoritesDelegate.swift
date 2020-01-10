//
//  FavoritesDelegate.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 09/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import Foundation

import UIKit

class FavoritesDelegate: NSObject, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    // TODO: Get this information from viewModel
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    
}
