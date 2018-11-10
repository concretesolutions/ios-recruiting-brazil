//
//  FilterController.swift
//  Wonder
//
//  Created by Marcelo on 09/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

class FilterController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    // MARK: - Public Properties
    public var movies = [FavoriteMovies]()  // Core Data Model
    
    
    //MARK: - Private Properties
    private var source = [String]()
    private var selectedIndexPath = IndexPath()
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setUp
        setUp()

    
    }
    
    // MARK: - App SetUp
    private func setUp() {
        // navigation bar title
        navigationItem.title = "Filter"
        
        // filter options
        source.append("Date")
        source.append("Genres")
    }
    
    
    
    // MARK: - TableView Data Source & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell") as! FilterCell
        cell.filterTitle.text = source[indexPath.row]
        cell.fiterDescription.text = String()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "showFilterSelection", sender: self)
        
    }
    
    
    // MARK: - UI Actions
    @IBAction func applyAction(_ sender: Any) {
        print("*** APPLY FILTER")
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFilterSelection" {
            let controller = segue.destination as! FilterSelectionController
            controller.filterSelectedRow = selectedIndexPath.row
            controller.movies = movies
        }
    }

}
