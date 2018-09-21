//
//  FilterDetailViewController.swift
//  Movies
//
//  Created by Jonathan Martins on 20/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

enum FilterOption{
    case date
    case genre
}

class FilterDetailViewController: UITableViewController {
    
    /// The cell's identifier
    private let identifier = "cell"
    
    /// The array to hold the items's values for dates
    private let dates = ["2018", "2017", "2016", "2015", "2014", "2013", "2012", "2011", "2010", "2009", "2008", "2007", "2006",
                         "2005", "2004", "2003", "2002", "2001", "2000", "1999", "1998", "1997", "1996", "1995", "1994", "1993", "1992",
                         "1991", "1990"]
    
    /// The array to hold the items's values for genres
    private var genres:[Genre] = []
    
    /// Indicates which items the controller will display
    var filterOption:FilterOption = .date
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewController()
    }
    
    /// Sets up the TableViewController
    private func setupTableViewController(){
        switch filterOption {
            case .date:
                self.title = "Date"
            case .genre:
                self.title = "Genres"
                createGenresArray()
        }
    
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
    /// Creates the genres array
    private func createGenresArray(){
        RequestMovie().genres().responseJSON { response in
            if let data = response.data, let result = try? JSONDecoder().decode(Result.self, from: data), let genres = result.genres{
                self.genres = genres
            }
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch filterOption {
            case .date:
                return dates.count
            case .genre:
                return genres.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
        switch filterOption {
            case .date:
                cell.textLabel?.text = dates[indexPath.row]
            case .genre:
                cell.textLabel?.text = genres[indexPath.row].name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch filterOption {
            case .date:
                Filter.current.date  = dates[indexPath.row]
            case .genre:
                Filter.current.genre = genres[indexPath.row]
        }
        navigationController?.popViewController(animated: true)
    }
}

