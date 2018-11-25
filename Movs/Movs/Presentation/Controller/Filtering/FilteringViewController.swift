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

struct Filter {
    var year = [Int]()
    var genre = [String]()
}

//TODO fazer um delegate para pegar qual ano e gênero foi selecionado na tvc seguinte

class FilteringViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let numberOfFilters = 2
    let filteringCellIdentifier = "filteringCell"
    let segueFilterDetail = "filteringToFilterDetail"
    var favorite = [Favorite]()
    var filter = Filter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        dataSetup()
    }
    
    func initialSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func dataSetup() {
        filter.genre = getListOfGenres()
        filter.year = getListOfYears()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FilterDetailTableViewController {
            // Genres
            if let sender = sender as? [String] {
                vc.genre = sender
            } else if let sender = sender as? [Int] { // Years
                vc.year = sender
            }
        }
    }
    
}

extension FilteringViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfFilters
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: filteringCellIdentifier) as? FilteringTableViewCell
        
        switch indexPath.row {
        case FilterOptions.Year.rawValue:
            cell?.setData(title: "Ano", filterChoosen: nil)
        case FilterOptions.Genre.rawValue:
            cell?.setData(title: "Gênero", filterChoosen: nil)
        default:
            break
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case FilterOptions.Year.rawValue:
        performSegue(withIdentifier: segueFilterDetail, sender: filter.year)
        case FilterOptions.Genre.rawValue:
        performSegue(withIdentifier: segueFilterDetail, sender: filter.genre)
        default:
            return
        }
    }
    
}

extension FilteringViewController {
    private func getListOfYears() -> [Int] {
        let years = favorite.compactMap { (fav) -> Date? in
            let date = fav.releaseDate as Date?
            return date
            }.map { (date) -> Int in
                return transformDateInYear(date)
        }
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
            let genre = fav.genres!.replacingOccurrences(of: " ", with: "")
            return genre
            }
        let stringOfGenres = genresArray.joined(separator: ",")
        let arrayOfGenres = stringOfGenres.split(separator: ",")
        /// Removendo os gêneros repetidos
        let uniqueGenres = arrayOfGenres.reduce(into: [String]()) {
            if !$0.contains(String($1)) {
                $0.append(String($1))
            }
        }
        return uniqueGenres
    }
}
