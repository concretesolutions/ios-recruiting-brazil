//
//  FilterTableDelegate.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 23/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit

class FilterTableDelegate: NSObject {
    
    weak var tableView:UITableView?
    weak var dataSource:UITableViewDataSource?
    
    override init() {
        super.init()
    }

}

extension FilterTableDelegate: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
}
