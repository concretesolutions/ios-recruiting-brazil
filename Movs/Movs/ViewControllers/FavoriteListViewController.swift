//
//  FavoriteListViewController.swift
//  Movs
//
//  Created by Alexandre Papanis on 30/03/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import UIKit
import CoreData
import Lottie

protocol FavoriteDelegate {
    func doFilter(genre: String?, date: String?)
}

class FavoriteListViewController: UIViewController, FavoriteDelegate {
    
    //MARK: Variables
    var isFiltered: Bool = false
    var filteredFavoriteMovies: [FavoriteMovie] = []
    var favoriteMovies: [FavoriteMovie] = []
    var genreSelected: String = ""
    var dateSelected: String = ""
    var searchedText: String = ""
    
    //MARK: IB Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightVwRemoveFilter: NSLayoutConstraint!
    @IBOutlet weak var lbFilters: UILabel!
    @IBOutlet weak var vwError: UIView!
    @IBOutlet weak var vwLoading: UIView!
    @IBOutlet weak var vwEmptyList: UIView!
    @IBOutlet weak var vwEmptyFilteredList: UIView!
    @IBOutlet weak var vwLoadingAnimation: UIView!
    
    
    //MARK: IB Actions
    @IBAction func filterFavorites(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showFilter", sender: nil)
    }
    
    @IBAction func removeFilters(_ sender: UIButton) {
        genreSelected = ""
        dateSelected = ""
        searchedText = ""
        heightVwRemoveFilter.constant = 0
        isFiltered = false
        getFavoriteMovies()
    }
    
    //MARK: UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        vwError.isHidden = true
        vwEmptyList.isHidden = true
        vwLoading.isHidden = false
        
        let loadingAnimation = LOTAnimationView(name: "loading")
        loadingAnimation.frame = CGRect(x: 0, y: 0, width: vwLoadingAnimation.frame.size.width, height: vwLoadingAnimation.frame.size.height)
        loadingAnimation.contentMode = .scaleAspectFit
        loadingAnimation.loopAnimation = true
        vwLoadingAnimation.addSubview(loadingAnimation)
        loadingAnimation.play(completion: { finished in
            print("rodando animacao")
        })
        
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavoriteMovies()
    }
    
    
    func setupNavBar(){
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.searchController?.delegate = self
        navigationItem.searchController?.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    //MARK: other methods
    fileprivate func getFavoriteMovies(){
        vwEmptyFilteredList.isHidden = true
        isFiltered = false
        
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(FavoriteMovie.title), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do{
            favoriteMovies = try PersistenceService.context.fetch(fetchRequest)
            print(favoriteMovies.count)
            
            filteredFavoriteMovies = favoriteMovies
            
            if searchedText != "" {
                isFiltered = true
                filteredFavoriteMovies = filteredFavoriteMovies.filter({$0.title!.localizedStandardContains(searchedText)})
            }
            
            if genreSelected != "" {
                filteredFavoriteMovies = filteredFavoriteMovies.filter({$0.genres!.contains(genreSelected)})
                isFiltered = true
            }
            
            if dateSelected != "" {
                filteredFavoriteMovies = filteredFavoriteMovies.filter({$0.year! == dateSelected})
                isFiltered = true
            }
            
            lbFilters.text = getFilters()
            
            tableView.reloadData()
            
            heightVwRemoveFilter.constant = isFiltered ? 50 : 0
            
            if favoriteMovies.count == 0 {
                vwEmptyList.isHidden = false
            } else {
                vwEmptyList.isHidden = true
                if filteredFavoriteMovies.count == 0 {
                    vwEmptyFilteredList.isHidden = false
                }
            }
            vwLoading.isHidden = true
            
        } catch {
            vwError.isHidden = false
        }
    }
    
    fileprivate func getFilters() -> String {
        var filter: String = ""
        
        if searchedText != "" {
            filter = "Title: \(searchedText)"
            if genreSelected != "" {
                filter = filter + ", Genre: \(genreSelected)"
                if dateSelected != "" {
                    filter = filter + ", Date: \(dateSelected)"
                }
            } else {
                if dateSelected != "" {
                    filter = filter + ", Date: \(dateSelected)"
                }
            }
        } else {
            if genreSelected != "" {
                filter = filter + "Genre: \(genreSelected)"
                if dateSelected != "" {
                    filter = filter + ", Date: \(dateSelected)"
                }
            } else {
                if dateSelected != "" {
                    filter = filter + "Date: \(dateSelected)"
                }
            }
            
        }
        
        return filter
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FilterViewController {
            vc.dateSelected = dateSelected
            vc.genreSelected = genreSelected
            vc.favoriteDelegate = self
        }
    }
    
    //MARK: FavoriteDelegate methods
    func doFilter(genre: String?, date: String?) {
        genreSelected = genre ?? ""
        dateSelected = date ?? ""
        getFavoriteMovies()
    }

}

extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: UITableViewController stubs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFavoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell") as! FavoriteCell
        
        cell.favoriteMovie = filteredFavoriteMovies[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            
            let selectedMovie = self.filteredFavoriteMovies[indexPath.row]
            
            FirebaseAnalyticsHelper.removeFavoriteEventLogger(movieId: Int(selectedMovie.id), movieTitle:selectedMovie.title ?? "")
            FavoriteMovie.removeFavoriteMovie(id: Int(selectedMovie.id))
            getFavoriteMovies()
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
}

extension FavoriteListViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedText = searchText
        isFiltered = true
        getFavoriteMovies()
    }
}
