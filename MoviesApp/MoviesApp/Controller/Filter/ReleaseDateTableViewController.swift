//
//  ReleaseDateTableViewController.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 21/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import UIKit

class ReleaseDateTableViewController: UITableViewController {

    var years : [String] = []
    var canAddToList = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Date"

        
        var movies = MovieDAO.readAllFavoriteMovies()
        
        for movie in movies{
            
            if self.years.contains(movie.release_date.components(separatedBy: "-")[0]){
                print("Exists")
            }else{
                self.years.append(movie.release_date.components(separatedBy: "-")[0])
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return years.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "releaseDateTableViewCell", for: indexPath) as! ReleaseDateTableViewCell

        cell.setupCell(title: years[indexPath.row])
        
        if FilterManager.shared.releaseDates.contains(self.years[indexPath.row]){
            cell.selectedButtonOutlet.isHidden = false
        }else{
            cell.selectedButtonOutlet.isHidden = true
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ReleaseDateTableViewCell
        print(cell.releaseTitleLabelOutlet.text)
        
        if FilterManager.shared.releaseDates.contains(self.years[indexPath.row]){
            print("Ja existe")
            
            FilterManager.shared.releaseDates.removeAll { (ano) -> Bool in
                if ano == self.years[indexPath.row] {
                    return true
                }
                return false
            }
            
            cell.selectedButtonOutlet.isHidden = true
            
        }else{
            FilterManager.shared.releaseDates.append(self.years[indexPath.row])
            cell.selectedButtonOutlet.isHidden = false
        }
        
        print(FilterManager.shared.releaseDates)
        
    }
}
