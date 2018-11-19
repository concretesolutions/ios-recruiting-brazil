//
//  FilteredMovies.swift
//  Movs
//
//  Created by Victor Rodrigues on 19/11/18.
//  Copyright © 2018 Victor Rodrigues. All rights reserved.
//

import UIKit
import CoreData

class FilteredMovies: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    var favoritesDB = [Favorites]()
    var moviesFound = [Favorites]()
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        fetchRequest()
        setFilter()
    }
    
}

//MARK: Functions
extension FilteredMovies {
    
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CellFavorites", bundle: nil), forCellReuseIdentifier: "cellFavorites")
    }
    
    func fetchRequest() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        do {
            favoritesDB = try CoreDataStack.managedObjectContext.fetch(fetchRequest) as! [Favorites]
        } catch {}
        AppDelegate.reachabilityStatus()
    }
    
    func setFilter() {
        guard let genre = defaults.string(forKey: keyGenre) else { return }
        guard let date = defaults.string(forKey: keyDate) else { return }
        
        if genre != "" && date != "" {
            setFilterDateAndGenre(date: date, genre: genre)
        } else if genre != "" && date == "" {
            setFilterGenre(genre: genre)
        } else if genre == "" && date != "" {
            setFilterDate(date: date)
        } else {
            print("nothing filter")
        }
        
        tableView.reloadData()
    }
    
    func setFilterDate(date: String) {
        for movie in favoritesDB {
            let dateComponents = movie.release_date!.components(separatedBy: "-")
            if let year = dateComponents.first {
                if year == date {
                    moviesFound.append(movie)
                }
            }
        }
    }
    
    func setFilterGenre(genre: String) {
        for movie in favoritesDB {
            if let g = movie.genre {
                let array = g.components(separatedBy: ", ")
                if array.contains(genre) {
                    moviesFound.append(movie)
                }
            }
        }
    }
    
    func setFilterDateAndGenre(date: String, genre: String) {
        for movie in favoritesDB {
            let dateComponents = movie.release_date!.components(separatedBy: "-")
            if let year = dateComponents.first, let g = movie.genre {
                let array = g.components(separatedBy: ", ")
                if year == date && array.contains(genre) {
                    moviesFound.append(movie)
                }
            }
        }
    }
    
}

//MARK: TableView
extension FilteredMovies: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.moviesFound.count == 0 {
            let errorView = ErrorView()
            errorView.imageView.image = UIImage(named: "sad")
            errorView.textMessage.text = "We couldn't find any favorites"
            self.tableView.backgroundView = errorView
        } else {
            self.tableView.backgroundView = nil
        }
        return self.moviesFound.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFavorites", for: indexPath) as! CellFavorites
        cell.config(favorited: moviesFound, at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
