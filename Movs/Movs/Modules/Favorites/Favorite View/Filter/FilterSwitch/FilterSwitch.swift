//
//  FilterSwitch.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 17/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class FilterSwitch: UITableViewController {
    
    // VIPER
    var presenter: FavoritesPresenter!
    var filter: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup
    
    func setup(filterName: String) {
        self.navigationItem.title = filterName
        if filterName == "Genres" {
            self.setupGenres()
        }
        if filterName == "Date" {
            self.setupYears()
        }
    }
    
    // Mark: - Call
    
    func setupGenres() {
        self.filter = []
        ServerManager.getMoviesGenres { (genres, status) in
            switch status {
            case .error:
                print("-> Error")
            case .okay:
                print("-> Movies: \(genres!.count)")
                if let movieGenres = genres {
                    for genre in movieGenres {
                        self.filter.append(genre.name!)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func setupYears() {
        self.filter = []
    }
    
    func reload() {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Prepare cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! FilterSwitchCell
        // Setup cell
        let genreTitle = self.filter[indexPath.row]
        let genreChecked = self.presenter.filterGenreChecked(with: genreTitle)
        cell.awakeFromNib(filterTitle: genreTitle, checked: genreChecked)
        // Return
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FilterSwitchCell {
            let filterString = self.filter[indexPath.row]
            if cell.checked {
                self.presenter.removeFilterGenre(with: filterString)
            }else{
                self.presenter.addFilterGenre(with: filterString)
            }
            cell.changeCheck()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filter.count
    }
    
}
