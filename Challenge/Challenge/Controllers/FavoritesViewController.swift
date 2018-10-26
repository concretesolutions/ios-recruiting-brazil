//
//  FavoritesViewController.swift
//  Challenge
//
//  Created by Sávio Berdine on 22/10/18.
//  Copyright © 2018 Sávio Berdine. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [Movie] = []
    var searchedMovies: [Movie] = [] {
        didSet {
            self.updateView()
        }
    }
    var filteredMovies: [Movie] = []
    var page = 1
    var usingCoredata: Bool?
    var searchActive = false
    static var filterIsActive = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let image = UIImage(named: "favorite_gray_icon")
        image?.draw(in: CGRect(x: 0, y: 0, width: 0, height: 0))
        tabBarItem = UITabBarItem(title: "Favorites", image: image, tag: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        if self.movies.count == 0 {
            self.usingCoredata = true
            self.movies = Movie.fetchSortedByDate()
            self.tableView.reloadData()
        }
        
        self.handlePagination()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Movie.favoritesChanged {
            self.page = 1
            handlePagination()
            self.tableView.reloadData()
        }
        if FavoritesViewController.filterIsActive {
            Filter.filter(movies: self.movies, onSuccess: { (moviesResult) in
                self.filteredMovies = moviesResult
                self.tableView.reloadData()
            }) { (error) in
                print(error)
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func clearFilter(_ sender: Any) {
        if FavoritesViewController.filterIsActive {
            FavoritesViewController.filterIsActive = false
            Filter.filterState.genre = ""
            Filter.filterState.year = ""
            self.tableView.reloadData()
        }
    }
    
    func updateView() {
        let hasSearchResult = self.searchedMovies.count > 0
        self.tableView.isHidden = !hasSearchResult && !(self.searchBar.text?.isEmpty)!
        if !hasSearchResult && !(self.searchBar.text?.isEmpty)!{
            print("No result in the search")
        }
    }
    
    @objc func handlePagination() {
        print("Handling pagination")
        Movie.getFavoriteMovies(pageToRequest: self.page, onSuccess: { (moviesResult) in
            if self.page == 1 {
                self.movies = []
                self.movies.append(contentsOf: moviesResult)
                Movie.saveMoviesToCoreData(movies: moviesResult)
            } else {
                self.movies.append(contentsOf: moviesResult)
                Movie.appendMoviesToCoreData(movies: moviesResult)
            }
            self.page += 1
            self.usingCoredata = false
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentOffset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.height
        if maxOffset - currentOffset <= 40 {
            if !FavoritesViewController.filterIsActive {
                self.handlePagination()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchActive {
            return searchedMovies.count
        } else if FavoritesViewController.filterIsActive && !searchActive {
            return self.filteredMovies.count
        } else {
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
        if searchActive {
            cell.favoriteTitle.text = self.searchedMovies[indexPath.row].name
            cell.favoriteYear.text = self.searchedMovies[indexPath.row].date?.dateYyyyMmDdToDdMmYyyyWithDashes()
            cell.favoriteOverview.text = self.searchedMovies[indexPath.row].overview
            cell.favoriteImageView.kf.indicatorType = .activity
            if usingCoredata ?? false {
                cell.favoriteImageView.image = searchedMovies[indexPath.row].image
            } else {
                cell.favoriteImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280/\(String(describing: self.searchedMovies[indexPath.row].imagePath!))"))
            }
        } else if FavoritesViewController.filterIsActive && !searchActive {
            cell.favoriteTitle.text = self.filteredMovies[indexPath.row].name
            cell.favoriteYear.text = self.filteredMovies[indexPath.row].date?.dateYyyyMmDdToDdMmYyyyWithDashes()
            cell.favoriteOverview.text = self.filteredMovies[indexPath.row].overview
            cell.favoriteImageView.kf.indicatorType = .activity
            if usingCoredata ?? false {
                cell.favoriteImageView.image = filteredMovies[indexPath.row].image
            } else {
                cell.favoriteImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280/\(String(describing: self.filteredMovies[indexPath.row].imagePath!))"))
            }
        } else {
            cell.favoriteTitle.text = self.movies[indexPath.row].name
            cell.favoriteYear.text = self.movies[indexPath.row].date?.dateYyyyMmDdToDdMmYyyyWithDashes()
            cell.favoriteOverview.text = self.movies[indexPath.row].overview
            cell.favoriteImageView.kf.indicatorType = .activity
            if usingCoredata ?? false {
                cell.favoriteImageView.image = movies[indexPath.row].image
            } else {
                cell.favoriteImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280/\(String(describing: self.movies[indexPath.row].imagePath!))"))
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 163
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "favoriteToDetail", sender: nil)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if FavoritesViewController.filterIsActive {
            self.searchedMovies = self.filteredMovies.filter({ (text) -> Bool in
                let tmp: NSString = (text.name! as NSString?)!
                let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
        } else {
            self.searchedMovies = self.movies.filter({ (text) -> Bool in
                let tmp: NSString = (text.name! as NSString?)!
                let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
        }
        
        if(self.searchedMovies.isEmpty) {
            self.searchActive = false
        } else {
            self.searchActive = true
        }
        self.tableView.reloadData()
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoriteToDetail" {
            let vc = segue.destination as! MovieDetailsViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let row = indexPath.row
                if self.searchActive {
                    vc.movie = self.searchedMovies[row]
                } else if FavoritesViewController.filterIsActive && !searchActive {
                    vc.movie = self.filteredMovies[row]
                } else {
                    vc.movie = self.movies[row]
                }
                let cell = self.tableView.cellForRow(at: indexPath) as! FavoriteTableViewCell
                vc.image = cell.favoriteImageView.image
                self.tableView.deselectRow(at: indexPath, animated: false)
            }
        }
    }
    

}
