//
//  FilterSettingsViewController.swift
//  DesafioConcrete
//
//  Created by Ian Manor on 17/12/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import UIKit

class FilterSettingsViewController: UIViewController, UITableViewDelegate {
    
    var dateFilter: String?
    var genreFilter: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "toDateFilters", sender: nil)
        } else {
            performSegue(withIdentifier: "toGenreFilters", sender: nil)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedSettingsTable" {
            let embeddedTableVC = segue.destination as! UITableViewController
            embeddedTableVC.tableView.delegate = self
        }
    }

}
