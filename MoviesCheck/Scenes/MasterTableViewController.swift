//
//  MasterTableViewController.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 26/10/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

//Screen navigation identifier
enum DestinationScreen:String{
    case home = "home"
    case movies = "movie"
    case tvShows = "tb"
    case favorites = "fav"
}

class MasterTableViewController: UITableViewController {
    
    //Identifier for the destination screen on segue
    var currentDestination = DestinationScreen.home
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "search" {
            
            let destinationNavigationController = segue.destination as! UINavigationController
            
            if let destinationViewController = destinationNavigationController.viewControllers.first as? SearchViewController{
                
                destinationViewController.searchType = currentDestination
                
            }
            
        }
        
        
    }
    
    // MARK: - Table View
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Change the color of selected row, ingonirg the first row
        if(indexPath.row != 0){
            let selectedCell = tableView.cellForRow(at: indexPath)
            selectedCell?.contentView.backgroundColor = UIColor(red:0.12, green:0.12, blue:0.12, alpha:1.0)
        }
        
        switch indexPath.row {
        case 1:
            currentDestination = .movies
            performSegue(withIdentifier: "search", sender: nil)
        case 2:
            currentDestination = .tvShows
            performSegue(withIdentifier: "search", sender: nil)
        case 3:
            currentDestination = .favorites
            performSegue(withIdentifier: "favorites", sender: nil)
        default:
            break
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        //Change the color of deselected row, ingonirg the first row
        if(indexPath.row != 0){
            let deSelectedCell = tableView.cellForRow(at: indexPath)
            deSelectedCell?.contentView.backgroundColor = UIColor(red:0.22, green:0.21, blue:0.20, alpha:1.0)
        }
        
    }

}
