//
//  FavoritesController.swift
//  Movs
//
//  Created by Victor Rodrigues on 16/11/18.
//  Copyright © 2018 Victor Rodrigues. All rights reserved.
//

import UIKit
import CoreData

class FavoritesController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    var favoritesDB = [Favorites]()
    var urlBanner = ""
    var titleMovie = ""
    var date = ""
    var overview = ""

    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchRequest()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goFilter" {
            _ = segue.destination as! FilterController
        }
    }

    @IBAction func filter(_ sender: UIBarButtonItem) {
        if favoritesDB.count == 0 {
            let alert = UIAlertController(title: "Attencion!", message: "You didn't select any favorites", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "goFilter", sender: nil)
        }
    }
    
}

//MARK: CoreData
extension FavoritesController {
    
    func fetchRequest() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        do {
            favoritesDB = try CoreDataStack.managedObjectContext.fetch(fetchRequest) as! [Favorites]
            
            for favorite in favoritesDB {
                urlBanner = (favorite).value(forKey: "poster_path") as! String
                titleMovie = (favorite).value(forKey: "title") as! String
                date = (favorite).value(forKey: "release_date") as! String
                overview = (favorite).value(forKey: "overview") as! String
            }
        } catch{}
        tableView.reloadData()
        AppDelegate.reachabilityStatus()
    }
    
}

//MARK: Functions
extension FavoritesController {
    
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CellFavorites", bundle: nil), forCellReuseIdentifier: "cellFavorites")
    }
    
}

extension FavoritesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.favoritesDB.count == 0 {
            let errorView = ErrorView()
            errorView.imageView.image = UIImage(named: "sad")
            errorView.textMessage.text = "You didn't select any favorites"
            self.tableView.backgroundView = errorView
        } else {
            self.tableView.backgroundView = nil
        }
        return self.favoritesDB.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFavorites", for: indexPath) as! CellFavorites
        
        cell.config(favorited: favoritesDB, at: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let favorited = favoritesDB.reversed()[(indexPath.row)]
            
            let context: NSManagedObjectContext = CoreDataStack.managedObjectContext
            context.delete(favorited as NSManagedObject)

            self.favoritesDB.remove(at: (indexPath.row))
            
            do {
                CoreDataStack.saveContext()
            } catch {
                print("Error while saving Data From DB")
            }

            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
            do {
                self.favoritesDB = try context.fetch(fetchRequest) as! [Favorites]
            } catch let error as NSError {
                print("Error While Fetching Data From DB: \(error.userInfo)")
            }

            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
