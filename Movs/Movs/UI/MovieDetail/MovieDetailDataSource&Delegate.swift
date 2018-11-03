//
//  MovieDetailDataSourceDelegate.swift
//  Movs
//
//  Created by Gabriel Reynoso on 30/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class MovieDetailDataSourceDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var items:[UITableViewCell]
    
    init(items:[UITableViewCell] = []) {
        self.items = items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.items[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300.0
        case 3:
            return 200.0
        default:
            return 60.0
        }
    }
}
