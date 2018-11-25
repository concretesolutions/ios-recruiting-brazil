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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.yearFilter.count
        case 1:
            return self.genreFilter.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        switch indexPath.section {
        case 0:
            let filterInfo = self.yearFilter.enumerated().first { (offset, _) -> Bool in
                return offset == indexPath.row
                }?.1
            guard let yearInfo = filterInfo else { return cell }
            
            cell.textLabel?.text = yearInfo.0
            cell.imageView?.image = UIImage(named: "check_icon")!
            cell.imageView?.isHidden = !yearInfo.1
            
        case 1:
            let filterInfo = self.genreFilter.enumerated().first { (offset, _) -> Bool in
                return offset == indexPath.row
                }?.1
            guard let genreInfo = filterInfo else { return cell }
            
            cell.textLabel?.text = genreInfo.0
            cell.imageView?.image = UIImage(named: "check_icon")!
            cell.imageView?.isHidden = !genreInfo.1
            
        default:
            fatalError("There is no such thing as a section number \(indexPath.section)")
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let filterInfo = self.yearFilter.enumerated().first { (offset, _) -> Bool in
                return offset == indexPath.row
                }?.1
            guard let yearInfo = filterInfo else { return }
            
            let value = !yearInfo.1
            self.yearFilter[yearInfo.0] = value
        case 1:
            let filterInfo = self.genreFilter.enumerated().first { (offset, _) -> Bool in
                return offset == indexPath.row
                }?.1
            guard let genreInfo = filterInfo else { return }
            
            let value = !genreInfo.1
            self.genreFilter[genreInfo.0] = value
        default:
            fatalError("Absurd scenario, selected row \(indexPath.row) in section \(indexPath.section)")
        }
        
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
