//
//  HomeFavoriteMovsDelegate.swift
//  FavoriteMovsFeature
//
//  Created by Marcos Felipe Souza on 27/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit

class HomeFavoriteMovsDelegate: NSObject, UITableViewDelegate {
    
    var selected: ((_ index: IndexPath) -> ())?
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selected?(indexPath)
    }
    
    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Não delete, por favor !🙏🏻"
    }
}
