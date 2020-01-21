//
//  MoviesFavoritedVC.swift
//  Movs
//
//  Created by Rafael Douglas on 20/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit
import CoreData

class MoviesFavoritedVC: UITableViewController {
    
    var fetchedResultController: NSFetchedResultsController<Movies>!
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        loadfavoritedMovies()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Favorite Movies"
        tableView.reloadData()
    }
    
    func setupSearchBar(){
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        
        navigationItem.searchController = searchController
        
        // Using extensions
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        self.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.definesPresentationContext = true
    }
    
    func loadfavoritedMovies(filtering: String = "") {
        let fetchRequest: NSFetchRequest<Movies> = Movies.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
       
        if !filtering.isEmpty {
            let predicate = NSPredicate(format: "title contains [c] %@", filtering)
            fetchRequest.predicate = predicate
        }
       
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
       
        do {
            try fetchedResultController.performFetch()
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = fetchedResultController?.fetchedObjects?.count ?? 0
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesFavoritedCell", for: indexPath) as! MoviesFavoritedCell
        guard let movie = fetchedResultController.fetchedObjects?[indexPath.row] else {
           return cell
        }
        
        cell.prepare(with: movie)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let movie = fetchedResultController.fetchedObjects?[indexPath.row] else {return}
            context.delete(movie)
           
            do {
                try context.save()
            } catch  {
                print(error.localizedDescription)
            }
        }
    }
}
