//
//  FilterParametersTableViewController.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 27/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import Reusable

class FilterParametersTableViewController: UITableViewController {

    var parameters:[String] = []

    init(parameters: [String], title: String , style: UITableView.Style) {
        self.parameters = parameters
        super.init(style: style)
        self.title = title
        self.tableView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: FilterTableViewCell.self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.parameters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FilterTableViewCell.self)
        cell.setupParameter(with: parameters[indexPath.row])
        return cell
    }
    


}
