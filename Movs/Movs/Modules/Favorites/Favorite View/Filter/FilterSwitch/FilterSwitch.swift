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
    var filter: [String] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
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
        let currentYear = Calendar.current.component(.year, from: Date())
        for year in 1890...currentYear {
            let y = String(year)
            self.filter.append(y)
        }
        self.filter.reverse()
    }
    
    // MARK: - Table view methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Prepare cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! FilterSwitchCell
        // Setup cell
        let cellTitle = self.filter[indexPath.row]
        var checked = false
        if self.navigationItem.title == "Genres" {
            checked = self.presenter.filterGenreChecked(with: cellTitle)
        }else if self.navigationItem.title == "Date" {
            checked = self.presenter.filterYearChecked(with: cellTitle)
        }
        cell.awakeFromNib(filterTitle: cellTitle, checked: checked)
        // Return
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FilterSwitchCell {
            let filterString = self.filter[indexPath.row]
            if cell.checked {
                if self.navigationItem.title == "Genres" {
                    self.presenter.removeFilterGenre(with: filterString)
                }else if self.navigationItem.title == "Date" {
                    self.presenter.removeFilterYear(with: filterString)
                }
            }else{
                if self.navigationItem.title == "Genres" {
                    self.presenter.addFilterGenre(with: filterString)
                }else if self.navigationItem.title == "Date" {
                    self.presenter.addFilterYear(with: filterString)
                }
            }
            cell.changeCheck()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filter.count
    }
    
}
