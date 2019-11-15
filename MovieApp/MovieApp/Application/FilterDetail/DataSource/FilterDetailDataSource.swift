//
//  FilterDetailDataSource.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 13/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

protocol FilterDetailDataSourceDelegate: class {
    func didSelect(text: String)
}

final class FilterDetailDataSource: NSObject {
    
    private weak var tableView: UITableView?
    private let delegate: FilterDetailDataSourceDelegate
    private var movieGenreDate: [String] = []
    
    init(tableView: UITableView, delegate: FilterDetailDataSourceDelegate) {
        self.delegate = delegate
        
        super.init()
        self.tableView = tableView
        registerCells()
        setupDataSource()
        
    }
    private func registerCells() {
        tableView?.register(FilterDetailCell.self, forCellReuseIdentifier: Strings.filterDetailCell)
    }
    
    private func setupDataSource() {
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
    func updateGenresDate(genreDate: [String]) {
        self.movieGenreDate = genreDate
        tableView?.reloadData()
    }
    
}

extension FilterDetailDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension FilterDetailDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieGenreDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: Strings.filterDetailCell)
        cell.backgroundColor = .background
        cell.textLabel?.textColor = .orange
        cell.textLabel?.text = movieGenreDate[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        delegate.didSelect(text: movieGenreDate[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}

