//
//  MovieDetailDataSource.swift
//  Movs
//
//  Created by Gabriel Reynoso on 30/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class MovieDetailDataSource: NSObject, UITableViewDataSource {
    
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
}
