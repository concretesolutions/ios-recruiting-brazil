//
//  FavoriteMoviesUITableView.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 16/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class DateFilterTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    var dates: [Date] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    var favoriteMovieRemoved: FavoriteMovieRemoved!
    
    // MARK: - UITableViewDelegate and UITableViewDataSource Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateFilterCell", for: indexPath) as! DateFilterTableViewCell
        
        cell.setupCell(date: self.dates[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
