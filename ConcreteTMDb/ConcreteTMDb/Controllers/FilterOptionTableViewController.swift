//
//  FilterOptionTableViewController.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 25/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import UIKit

class FilterOptionTableViewController: UITableViewController {
    
    var filterByDate: Bool = false
    var year: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        let date = Date()
        let calendar = Calendar.current
        self.year = calendar.component(.year, from: date)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 118
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if let year = self.year {
            cell.textLabel?.text = ""
            cell.textLabel?.text = "\(year - indexPath.row)"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            
        }
    }
    
    

}
