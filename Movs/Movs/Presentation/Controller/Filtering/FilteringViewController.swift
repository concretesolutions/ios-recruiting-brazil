//
//  ViewController.swift
//  Movs
//
//  Created by Adann Simões on 12/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

private enum FilterOptions: Int {
    case Year = 0,
    Genre
}

protocol FilteringDelegate: class {
    func setFilter(_ filter: Filter)
}

class FilteringViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let numberOfFilters = 2
    let filteringCellIdentifier = "filteringCell"
    let segueFilterDetail = "filteringToFilterDetail"
    
    var favorite = [Favorite]()
    var filterSelected = Filter()
    var filterToApply = Filter()
    var genreSelected: String?
    var yearSelected: Int?
    
    weak var delegate: FilteringDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        dataSetup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FilterDetailTableViewController {
            // Genres
            if let sender = sender as? [String] {
                vc.genre = sender
            } else if let sender = sender as? [Int] { // Years
                vc.year = sender
            }
            vc.delegate = self
        }
    }
    
    @IBAction func applyFilterButtonAction(_ sender: UIButton) {
        if let genre = genreSelected {
            filterToApply.genre = [genre]
        }
        if let year = yearSelected {
            filterToApply.year = [year]
        }
        if genreSelected != nil || yearSelected != nil {
            delegate?.setFilter(filterToApply)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: Data setup
extension FilteringViewController {
    private func initialSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func dataSetup() {
        filterSelected.genre = getListOfGenres()
        filterSelected.year = getListOfYears()
    }
}

// MARK: TableView Data source
extension FilteringViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfFilters
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: filteringCellIdentifier) as? FilteringTableViewCell
        
        switch indexPath.row {
        case FilterOptions.Year.rawValue:
            if let year = yearSelected {
                cell?.setData(title: "Ano", filterChoosen: String(year))
            } else {
                cell?.setData(title: "Ano", filterChoosen: nil)
            }
        case FilterOptions.Genre.rawValue:
            if let genre = genreSelected {
                cell?.setData(title: "Gênero", filterChoosen: genre)
            } else {
                cell?.setData(title: "Gênero", filterChoosen: nil)
            }
        default:
            break
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case FilterOptions.Year.rawValue:
        performSegue(withIdentifier: segueFilterDetail, sender: filterSelected.year)
        case FilterOptions.Genre.rawValue:
        performSegue(withIdentifier: segueFilterDetail, sender: filterSelected.genre)
        default:
            return
        }
    }
    
}

// MARK: Filtering Funcions
extension FilteringViewController {
    private func getListOfYears() -> [Int] {
        let years = favorite.compactMap { (fav) -> Date? in
            let date = fav.releaseDate as Date?
            return date
            }.map { (date) -> Int in
                return transformDateInYear(date)
        }
        /// Removing repeated years
        let uniqueYears = years.reduce(into: [Int]()) {
            if !$0.contains(Int($1)) {
                $0.append(Int($1))
            }
        }
        return uniqueYears
    }
    
    private func transformDateInYear(_ date: Date) -> Int {
        let myCalendar = Calendar(identifier: .gregorian)
        let year = myCalendar.component(.year, from: date)
        return year
    }
    
    private func getListOfGenres() -> [String] {
        let genresArray = favorite.compactMap { (fav) -> String? in
            let genre = fav.genres
            return genre
            }
        let stringOfGenres = genresArray.joined(separator: ",")
        let arrayOfGenres = stringOfGenres.split(separator: ",")
        let genreWithoutWhiteSpaceInBegin = arrayOfGenres.map { (genre) -> String in
            if genre.first == " " {
                var item = genre
                item.removeFirst()
                return String(item)
            }
            return String(genre)
        }
        /// Removing repeated genres
        let uniqueGenres = genreWithoutWhiteSpaceInBegin.reduce(into: [String]()) {
            if !$0.contains(String($1)) {
                $0.append(String($1))
            }
        }
        
        return uniqueGenres
    }
}

// MARK: Delegate
extension FilteringViewController: FilterDetailDelegate {
    func setSelectedGenre(_ filter: String) {
        genreSelected = filter
        tableView.reloadData()
    }
    
    func setSelectedYear(_ filter: Int) {
        yearSelected = filter
        tableView.reloadData()
    }
}
