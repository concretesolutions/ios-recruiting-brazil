//
//  FavoriteMoviesTableDelegate.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 17/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation
import UIKit

class FavoriteMoviesTableDelegate: NSObject, UITableViewDelegate{
    
    var isFiltering:Bool
    weak var dataSource: FavoriteMoviesDataSource?
    
    init(isFiltering:Bool){
        self.isFiltering = isFiltering
        super.init()
    }
    
    required override init() {
        self.isFiltering = false
        super.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isFiltering && indexPath.row == 0{
            return 60
        }
        return tableView.frame.height/5
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering && indexPath.row == 0{
            (tableView as! MoviesTableView).resetFilters()
        }
        
    }
}
