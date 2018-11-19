//
//  FilterController.swift
//  Movs
//
//  Created by Victor Rodrigues on 18/11/18.
//  Copyright © 2018 Victor Rodrigues. All rights reserved.
//

import UIKit

class FilterController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    var listFilter = ["Date", "Genre"]
    var listFavoriteDB = [Favorites]()
    var dateSelected = ""
    var genreSelected = ""
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goFilterDate" {
            _ = segue.destination as! DateFilterController
        } else if segue.identifier == "goFilterGenre" {
            _ = segue.destination as! GenreFilterController
        } else if segue.identifier == "filteredMovies" {
            _ = segue.destination as! FilteredMovies
        }
    }

    //MARK: Actions
    @IBAction func apply(_ sender: UIButton) {
        defaults.set(dateSelected, forKey: dateToFilter)
        defaults.set(genreSelected, forKey: genreToFilter)
        defaults.synchronize()
        performSegue(withIdentifier: "filteredMovies", sender: nil)
    }
    
}

//MARK: Functions
extension FilterController {
    
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FilterCell", bundle: nil), forCellReuseIdentifier: "filterCell")
    }
    
}

//MARK: TableView
extension FilterController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFilter.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! FilterCell
        
        cell.textLabel?.text = listFilter[indexPath.row]
        
        switch indexPath.row {
        case 0:
            if let date = defaults.string(forKey: keyDate) {
                cell.detailTextLabel?.text = date
                dateSelected = date
            } else {
                cell.detailTextLabel?.text = ""
                dateSelected = ""
            }
        default:
            if let genre = defaults.string(forKey: keyGenre) {
                cell.detailTextLabel?.text = genre
                genreSelected = genre
            } else {
                cell.detailTextLabel?.text = ""
                genreSelected = ""
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "goFilterDate", sender: nil)
        default:
            performSegue(withIdentifier: "goFilterGenre", sender: nil)
        }
    }

}
