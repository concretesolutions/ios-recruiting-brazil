//
//  PopularMoviesTableViewController.swift
//  Movs
//
//  Created by Adann Simões on 14/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

class PopularViewController: UITableViewController {
    // MARK: Behavior IBOutlets
    @IBOutlet var emptySearchView: UIView!
    @IBOutlet var genericErrorView: UIView!
    @IBOutlet var loadingView: UIView!
    
    // MARK: Class Attributes
    var popularMovie: PopularMovie?
    var behavior: Behavior = .LoadingView {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup() {
        fetchMovieData(page: 1) { (data) -> Void in
            if data != nil {
                self.popularMovie = data
                self.setBehavior(newBehavior: .PopularMovies)
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if popularMovie != nil {
            return 1
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

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

// MARK: Frufru setup
extension PopularViewController {
    private func setBehavior(newBehavior: Behavior) {
        behavior = newBehavior
        switch behavior {
        case .PopularMovies:
            self.tableView.backgroundView?.isHidden = true
        case .EmptySearch:
            self.tableView.backgroundView?.isHidden = false
            self.tableView.backgroundView = emptySearchView
        case .LoadingView:
            self.tableView.backgroundView?.isHidden = false
            self.tableView.backgroundView = loadingView
        case .GenericError:
            self.tableView.backgroundView?.isHidden = false
            self.tableView.backgroundView = genericErrorView
        }
    }
}

// MARK: Service setup
extension PopularViewController {
    func fetchMovieData(page: Int, completionHandler: @escaping (PopularMovie?) -> Void) {
        setBehavior(newBehavior: .LoadingView)
        PopularMovieServices.getPopularMovie(page: page) { (data, _) in
            if data != nil {
                print(data?.totalPages)
                completionHandler(data)
            } else {
                self.setBehavior(newBehavior: .GenericError)
                completionHandler(nil)
            }
        }
    }
}
