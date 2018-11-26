//
//  FilterTableViewController.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 25/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController {
    
    

    @IBAction func saveFilter(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var segueStr = ""
        if indexPath.row == 0 {
            segueStr = "date"
        } else {
            segueStr = "genre"
        }
        self.performSegue(withIdentifier: segueStr, sender: self)
    }

}

extension FilterTableViewController: ApplyFilter {
    
    func applyDateFilter(dates: [Int]) {
        
    }
    
    func applyGenreFilter(genres: [Genre]) {
        
    }
    
    
}
