//
//  FilterParameterTableViewController.swift
//  Movs
//
//  Created by Erick Lozano Borges on 21/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit

enum FilterParameterType {
    case releaseYear
    case genre
}

class FilterParameterTableViewController: UITableViewController {
    
    //MARK: - Properties
    var delegate: MovieFilterDelegate?
    // Datasources
    var availableGenres = [Genre(id: -1, name:"")]
    var availableReleaseYears = [""]
    // Configurations
    var parameterType:FilterParameterType
    
    //MARK: - Initializers
    init(delegate: MovieFilterDelegate, forGenres availableGenres: [Genre], style: UITableView.Style = .plain) {
        self.delegate = delegate
        self.parameterType = .genre
        self.availableGenres.append(contentsOf: availableGenres)
        super.init(nibName: nil, bundle: nil)
        tableView.tableFooterView = UIView()
        registerCells()
    }
    
    init(delegate: MovieFilterDelegate, forReleaseYears availableReleaseYears: [String], style: UITableView.Style = .plain) {
        self.delegate = delegate
        self.parameterType = .releaseYear
        self.availableReleaseYears.append(contentsOf: availableReleaseYears)
        super.init(nibName: nil, bundle: nil)
        tableView.tableFooterView = UIView()
        registerCells()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    func registerCells() {
        tableView.register(cellType: FilterTableViewCell.self)
    }
    
    //MARK: - TableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch parameterType {
        case .genre: return availableGenres.count
        case .releaseYear: return availableReleaseYears.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FilterTableViewCell.self)
        switch parameterType {
        case .genre:
            let genre = availableGenres[indexPath.row].name ?? "corrupted"
            cell.setup(description: genre.isEmpty ? "Sem Filtro" : genre)
        case .releaseYear:
            let year = availableReleaseYears[indexPath.row]
            cell.setup(description: year.isEmpty ? "Sem Filtro" : year)
        }
        return cell
    }
    
    //MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FilterTableViewCell {
            cell.showDetail()
            switch parameterType {
            case .genre:
                let genre = availableGenres[indexPath.row].name ?? "corrupted"
                delegate?.filter.updateParameter(ofType: .genre, withValue: genre.isEmpty ? nil : genre)
            case .releaseYear:
                let year = availableReleaseYears[indexPath.row]
                delegate?.filter.updateParameter(ofType: .releaseYear, withValue: year.isEmpty ? nil : year)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FilterTableViewCell {
            cell.hideDetail()
        }
    }

}
