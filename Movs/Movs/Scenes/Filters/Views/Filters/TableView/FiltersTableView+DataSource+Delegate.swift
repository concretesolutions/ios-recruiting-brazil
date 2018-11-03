//
//  FiltersTableView+DataSource+Delegate.swift
//  Movs
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

extension FiltersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return self.tableView.date
        case 1:
            return self.tableView.genre
        default:
            return UITableViewCell()
        }
    }
    
    
}

extension FiltersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var request = Filters.Request(type: .date)
        
        switch indexPath.row {
        case 0:
            request.type = .date
        case 1:
            request.type = .genre
        default:
            return
        }
        
        interactor.storeFilter(request: request)
        router.showFiltersOption()
    }
    
}
