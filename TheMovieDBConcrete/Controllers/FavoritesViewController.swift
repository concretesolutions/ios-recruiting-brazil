//
//  FavoritesViewController.swift
//  MovieDBConcrete
//
//  Created by eduardo soares neto on 20/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    
    var favoriteMovies: Movies = Movies()
    var searchActive = false
    var filteredMovies: Movies = Movies()
    var requestHasError = false
    
    @IBOutlet weak var favoritesFilterSearchBar: UISearchBar!
    @IBOutlet weak var favoritesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        //NotificationCenter.default.addObserver(self, selector: #selector(favoriteMoviesChanged(_:)), name: NSNotification.Name(rawValue: "favoriteChanged"), object: nil)
        
        favoriteMovies = PersistenceService.retrieveFavoriteMovies()
        favoritesTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteMovies = PersistenceService.retrieveFavoriteMovies()
        favoritesTableView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func favoriteMoviesChanged(_ notification:Notification) {
        favoriteMovies = PersistenceService.retrieveFavoriteMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func removeFilter(_ sender: Any) {
        favoritesFilterSearchBar.text = ""
        searchActive = false
        self.favoritesTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredMovies.movies = favoriteMovies.movies.filter({ (text) -> Bool in
            let tmp: NSString = (text.name as NSString?)!
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if searchText == "" {
            searchActive = false
        } else {
            searchActive = true
        }
        print("111111")
        self.favoritesTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filteredMovies.movies.count
        } else {
            return favoriteMovies.movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath as IndexPath) as! FavoriteTableViewCell
        if searchActive {
            cell.movieImage.image = filteredMovies.movies[indexPath.row].backgroundImage
            cell.movieNameLabel.text = filteredMovies.movies[indexPath.row].name
            cell.movieDescriptionLabel.text = filteredMovies.movies[indexPath.row].movieDescription
            cell.yearLabel.text = filteredMovies.movies[indexPath.row].year
        } else {
            cell.movieImage.image = favoriteMovies.movies[indexPath.row].backgroundImage
            cell.movieNameLabel.text = favoriteMovies.movies[indexPath.row].name
            cell.movieDescriptionLabel.text = favoriteMovies.movies[indexPath.row].movieDescription
            cell.yearLabel.text = favoriteMovies.movies[indexPath.row].year
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieViewControllerId") as? MovieViewController {
            vc.movie = self.favoriteMovies.movies[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let unfavorite = UITableViewRowAction(style: .destructive, title: "Unfavorite") { (action, indexPath) in
            // delete item at indexPath
            
            print(indexPath.row)
            print(self.favoriteMovies.movies.first?.name)
            PersistenceService.removeFavorite(withName: self.favoriteMovies.movies[indexPath.row].name)
            self.favoriteMovies.movies.remove(at: indexPath.row)
            self.favoritesTableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [unfavorite]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
