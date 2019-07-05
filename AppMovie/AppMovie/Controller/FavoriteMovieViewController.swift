//
//  FavoriteMovieViewController.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 05/07/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class FavoriteMovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - PROPERTIES
    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var movieSearch: UISearchBar!
    
    var movies: [MovieEntity] = []
    
    //MARK: -INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        favoriteTableView.reloadData()
        configureViewComponents()
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                if movies.count >= 1 {
                    favoriteTableView.isHidden = false
                } else {
                    favoriteTableView.isHidden = true
                }
            }
        }
    }
    
    func configureViewComponents(){
        //Navigation Controller
        self.navigationItem.title = "Favoritos"
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.mainColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.mainColor()
        self.navigationController?.navigationBar.tintColor = UIColor.mainDarkBlue()
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainDarkBlue(), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        //
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //Search
        movieSearch.barTintColor = UIColor.mainColor()
        movieSearch.tintColor = UIColor.mainOrange()
        movieSearch.showsCancelButton = false
        for v:UIView in movieSearch.subviews.first!.subviews {
            if v.isKind(of: UITextField.classForCoder()) {
                (v as! UITextField).tintColor = UIColor.white
                (v as! UITextField).backgroundColor = UIColor.mainOrange()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteMovieCell") as? FavoriteMovieCell else { return UITableViewCell() }
        let movie = movies[indexPath.row]
        cell.configureCell(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Unfavorite") { (rowAction, indexPath) in
            self.removeMovie(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        return [deleteAction]
    }
    
    @IBAction func moviesBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
}

extension FavoriteMovieViewController{
    
    func removeMovie(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(movies[indexPath.row])
        
        do {
            try managedContext.save()
            print("Successfully removed goal!")
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
    }
    
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        
        do {
            movies = try managedContext.fetch(fetchRequest)
            print("Successfully fetched data.")
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
}
