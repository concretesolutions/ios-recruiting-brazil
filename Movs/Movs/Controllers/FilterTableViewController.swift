//
//  FilterTableViewController.swift
//  Movs
//
//  Created by Julio Brazil on 25/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit

private let reuseIdentifier = "filterCell"

class FilterTableViewController: UITableViewController {
    var movies = [Movie]()
    
    var yearFilter = [String: Bool]()
    var genreFilter = [String: Bool]()
    
    private var applyFilterAction: ([Movie]) -> Void
    
    init(filtering movies: [Movie], completion: @escaping ([Movie]) -> Void) {
        self.movies = movies
        self.applyFilterAction = completion
        
        super.init(nibName: nil, bundle: nil)
        
        movies.forEach { (movie) in
            let year = movie.release_date.components(separatedBy: "-").first!
            let genres = movie.genre_names.components(separatedBy: ", ")
            
            if self.yearFilter[year] == nil {
                self.yearFilter.updateValue(false, forKey: year)
            }
            
            genres.forEach({ (genre) in
                if self.genreFilter[genre] == nil {
                    self.genreFilter.updateValue(false, forKey: genre)
                }
            })
        }
        
        self.title = "Filter"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

        self.navigationItem.rightBarButtonItem = {
            let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.applyFilter))
            return button
        }()
    }
    
    // MARK: - custom methods
    
    @objc func applyFilter() {
        let filteredMovies: [Movie] = self.movies.filter { (movie) -> Bool in
            let year = movie.release_date.components(separatedBy: "-").first!
            let genres = movie.genre_names.components(separatedBy: ", ")
            
            let amountOfGenreThatMatchFilter = genres.filter({ (genre) -> Bool in
                return (self.genreFilter[genre] ?? false)
            }).count
            
            return (amountOfGenreThatMatchFilter > 0 || (self.yearFilter[year] ?? false))
        }
        
        self.applyFilterAction(filteredMovies)
        self.navigationController?.popViewController(animated: true)
    }
}
