//
//  BaseTableViewDataSource.swift
//  CommonsModule
//
//  Created by Marcos Felipe Souza on 18/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit

open class BaseTableViewDataSource: NSObject,  UITableViewDataSource {
    private var list: [String]
    private var reuseCell: String
    private var tableView: UITableView
    public init(in tableView: UITableView, list: [String], identifierCell: String = "cell") {
        self.list = list
        self.reuseCell = identifierCell
        self.tableView = tableView
        super.init()
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.register(BaseTableViewCell.self, forCellReuseIdentifier: reuseCell)
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseCell, for: indexPath) as? BaseTableViewCell {
            cell.informationCell = (self.list[indexPath.row], nil)
            return cell
        }
        return UITableViewCell()
    }
}
