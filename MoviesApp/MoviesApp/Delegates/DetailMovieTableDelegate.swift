//
//  DetailMovieTableDelegate.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 18/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation
import UIKit

class DetailMovieTableDelegate: NSObject, UITableViewDelegate{
    
    required override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0:
            return tableView.frame.width * 1.481481481
        case 1:
            return 80
        case 5:
            return UITableView.automaticDimension
        default:
            return 60
        }
    }
    
}
