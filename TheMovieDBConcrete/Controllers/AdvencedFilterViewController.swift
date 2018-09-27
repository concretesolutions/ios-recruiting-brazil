//
//  AdvencedFilterViewController.swift
//  TheMovieDBConcrete
//
//  Created by eduardo soares neto on 27/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

class AdvencedFilterViewController: UIViewController,UITabBarDelegate,UITableViewDataSource {
    
    var dateChosen = ""
    var genreChosen = Genre()
    
    @IBOutlet weak var filtersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func applyFilter(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value2, reuseIdentifier: "filter")
        if indexPath.row == 0 {
            cell.textLabel?.text = "Date"
            cell.detailTextLabel?.text = dateChosen
        } else {
            cell.textLabel?.text = "Genres"
            cell.detailTextLabel?.text = genreChosen.name
        }
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
