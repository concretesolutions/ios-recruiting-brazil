//
//  FilterViewController.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 21/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewOutlet.dataSource = self
        self.tableViewOutlet.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterSelectionTableViewCell", for: indexPath) as! FilterSelectionTableViewCell
        
        if indexPath.row == 0{
            
            cell.setupCell(filterTitle: "Date")
            
        }else if indexPath.row == 1{
            
            cell.setupCell(filterTitle: "Genres")
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Filter", bundle: nil)
        
        if indexPath.row == 0{
            
            let viewController = storyboard.instantiateViewController(withIdentifier: "releaseDateTableViewController") as! ReleaseDateTableViewController
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }else if indexPath.row == 1{
            
             let viewController = storyboard.instantiateViewController(withIdentifier: "genderTableViewController") as! GenderTableViewController
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }


}

