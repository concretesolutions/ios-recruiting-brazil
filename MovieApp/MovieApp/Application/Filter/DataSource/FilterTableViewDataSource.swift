//
//  FilterTableViewDataSource.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 13/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//


import UIKit

enum TableViewCase: Int {
    case numberOfRows = 2
}

protocol FilterDataSourceDelegate: class {
    func didSelected(index: Int)
}

final class FilterTableViewDataSource: NSObject {
    
    private weak var tableView: UITableView?
    private let delegate: FilterDataSourceDelegate
    private var movies: [Movie] = []

    
    init(tableView: UITableView, delegate: FilterDataSourceDelegate) {
        self.delegate = delegate
        
        super.init()
        self.tableView = tableView
        registerCell()
        setupDataSource()
        
    }
    
    func registerCell() {
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: Strings.filterCell)
    }
    
    private func setupDataSource() {
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
    func updateMovies(movies: [Movie]) {
        self.movies = movies
        tableView?.reloadData()
    }
    
}

extension FilterTableViewDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewCase.numberOfRows.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: Strings.filterCell)
        cell.backgroundColor = .background
        cell.textLabel?.textColor = .orange
        cell.detailTextLabel?.textColor = .white
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = Strings.labelGenreFilter
            cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: Strings.userDefaultsFilterDetailGenreKey)
        case 1:
            cell.textLabel?.text = Strings.labelYearFilter
            cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: Strings.userDefaultsFilterDetailYearKey)
        default:
            cell.textLabel?.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelected(index: indexPath.row)
        self.tableView?.deselectRow(at: indexPath, animated: true)
    }
    
}


