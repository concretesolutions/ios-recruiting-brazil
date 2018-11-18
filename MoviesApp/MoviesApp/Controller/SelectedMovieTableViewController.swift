//
//  SelectedMovieTableViewController.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 12/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import UIKit

class SelectedMovieTableViewController: UITableViewController {
    
    var movie: Movie?
    
    @IBOutlet weak var movieImageOutlet: UIImageView!
    @IBOutlet weak var movieTitleOutlet: UILabel!
    @IBOutlet weak var movieReleaseDateOutlet: UILabel!
    @IBOutlet weak var movieGenreOutlet: UILabel!
    @IBOutlet weak var movieOverviewOutlet: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        //self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        if let title = self.movie?.title {
            self.movieTitleOutlet.text = title
        }
        
        if let releaseDate = self.movie?.release_date {
            self.movieReleaseDateOutlet.text = releaseDate
        }
        
        var genres: String = ""
        
        for genre in (self.movie?.genre_ids)! {
            genres += "   " + String(genre)
        }
        
        if let overview = self.movie?.overview {
            self.movieOverviewOutlet.text = overview
        }
        
        self.movieGenreOutlet.text = genres
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
