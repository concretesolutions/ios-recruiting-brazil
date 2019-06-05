//
//  FavoritesViewController.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 04/06/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    @IBOutlet weak var tableViewFavorites: UITableView!
    
    private static let numberOfSections = 1
    private static let heightForRow: CGFloat = 150
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDelegateAndDataSource()
        registerNibForTableViewCell()
        tableViewFavorites.removeSpaces()
        
        print("view did load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMoviesFromCoreData()
    }
    
    func getMoviesFromCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ManageData.entityName)
        
        movies = []
        
        do {
            let result = try managedContext.fetch(fetchRequest)
        
            for data in result as! [NSManagedObject] {
                guard let movieTitle: String = data.value(forKey: MoviesCoreData.title.rawValue) as? String else { return }
                guard let movieDescription = data.value(forKey: MoviesCoreData.resume.rawValue) as? String else { return }
                guard let moviePoster = data.value(forKey: MoviesCoreData.poster.rawValue) as? String else { return }
                guard let movieReleaseDate = data.value(forKey: MoviesCoreData.releaseDate.rawValue) as? String else { return }
                
                let favoriteMovie = Movie(title: movieTitle, image: moviePoster, description: movieDescription, releaseDate: movieReleaseDate)
                
                movies.append(favoriteMovie)
                tableViewFavorites.reloadData()
            }
        } catch {
            print("Failed")
        }
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableViewDelegateAndDataSource() {
        self.tableViewFavorites.delegate = self
        self.tableViewFavorites.dataSource = self
    }
    
    func registerNibForTableViewCell() {
        tableViewFavorites.registerNibForTableViewCell(FavoritesTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FavoritesViewController.heightForRow
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewFavorites.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.reusableIdentifier, for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell() }
        
        cell.setData(for: movies[indexPath.row])
        
        return cell
    }
}
