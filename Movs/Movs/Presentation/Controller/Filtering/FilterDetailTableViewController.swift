//
//  FilterDetailTableViewController.swift
//  Movs
//
//  Created by Adann Simões on 22/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

private enum FilterBehavior {
    case Genre
    case Year
}

class FilterDetailTableViewController: UITableViewController {
    var genre = [String]()
    var year = [Int]()
    private var behavior: FilterBehavior = .Genre
    
    let filterDetailCellIdentifier = "filterDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !genre.isEmpty {
            behavior = .Genre
        } else if !year.isEmpty {
            behavior = .Year
        }
        
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch behavior {
        case .Genre:
            return genre.count
        case .Year:
            return year.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: filterDetailCellIdentifier,
                                                 for: indexPath) as? FilterDetailTableViewCell
        
        switch behavior {
        case .Genre:
            cell?.setData(genre: genre[indexPath.row])
        case .Year:
            cell?.setData(year: year[indexPath.row])
        }

        return cell!
    }

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
