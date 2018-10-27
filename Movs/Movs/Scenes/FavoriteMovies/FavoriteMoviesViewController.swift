//
//  FavoriteMoviesViewController.swift
//  Movs
//
//  Created by Maisa on 27/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit
import CoreData

class FavoriteMoviesViewController: UIViewController, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    let favoritesWorker = FavoriteMoviesWorker()
    
    @IBOutlet weak var tableView: UITableView!
    
//    var favoriteMovies: [NSManagedObject] = []
//
//    var managedObjectContext: NSManagedObjectContext? = nil
//    var _fetchedResultsController: NSFetchedResultsController<MovieCoreData>? = nil
//
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "MyTasks")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    var fetchedResultsController: NSFetchedResultsController<MovieCoreData>?{
//        if _fetchedResultsController != nil {
//            return _fetchedResultsController!
//        }
//        // Creating a fetch request with the pretended type.
//        let fetchRequest: NSFetchRequest<MovieCoreData> = MovieCoreData.fetchRequest()
//        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//
//        fetchRequest.sortDescriptors = [sortDescriptor]
//
//        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
//        aFetchedResultsController.delegate = self
//
//        // Setting the created instance to the view controller instance.
//        _fetchedResultsController = aFetchedResultsController
//
//        do { try _fetchedResultsController!.performFetch() } catch {
//            let nserror = error as NSError
//            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//        }
//
////        return _fetchedResultsController!
//    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        print("😁 favorites did load")
//        managedObjectContext = persistentContainer.viewContext
        let movie = MovieDetailed(id: 123, genres: [], title: "woww title", overview: "super overview", releaseDate: "", posterPath: "", voteAverage: 3.0, isFavorite: true)
        favoritesWorker.addFavoriteMovie(movie: movie)
        favoritesWorker.getFavoriteMovies()
    }
    
    // MARK: - Fetch Results delegate
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
    
    
    
}

//extension FavoriteMoviesViewController: UITableViewDataSource  {
//
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return self.getMovies()?.sections?[section].numberOfObjects ?? 0
////    }
////
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        // First we get a cell from the table view with the identifier "Cell"
////        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
////
////        // Then we get the object at the current index from the fetched results controller
////        let task = self.fetchedResultsController.object(at: indexPath)
////
////        // And update the cell label with the task name
////        cell.textLabel!.text = task.name
////
////        // Finally we return the updated cell
////        return cell
////    }
//
//}
