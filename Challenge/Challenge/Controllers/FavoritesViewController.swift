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
    var filteredMovies: [Movie] = [] {
        didSet {
            self.updateView()
        }
    }
    var page = 1
    var usingCoredata: Bool?
    var searchActive = false
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        self.tableView.addSubview(self.refreshControl)
        
        return refreshControl
    }()
    
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func updateView() {
        let hasSearchResult = self.filteredMovies.count > 0
        self.tableView.isHidden = !hasSearchResult
        if !hasSearchResult {
            print("No result in the search")
        }
    }
    
    @objc func handlePagination() {
        print("Handling pagination")
        Movie.getFavoriteMovies(pageToRequest: self.page, onSuccess: { (moviesResult) in
            self.movies = []
            self.movies.append(contentsOf: moviesResult)
            if self.page == 1 {
                Movie.saveMoviesToCoreData(movies: moviesResult)
            } else {
                Movie.appendMoviesToCoreData(movies: moviesResult)
            }
            self.page += 1
            self.usingCoredata = false
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("Handling refresh")
        self.page = 1
        handlePagination()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentOffset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.height
        if maxOffset - currentOffset <= 40 {
            self.handlePagination()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchActive {
            return filteredMovies.count
        }
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
        if searchActive {
            cell.favoriteTitle.text = self.filteredMovies[indexPath.row].name
            cell.favoriteYear.text = self.filteredMovies[indexPath.row].date?.dateYyyyMmDdToDdMmYyyyWithDashes()
            cell.favoriteOverview.text = self.filteredMovies[indexPath.row].overview
            cell.favoriteImageView.kf.indicatorType = .activity
            if usingCoredata ?? false {
                cell.favoriteImageView.image = movies[indexPath.row].image
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
        
        self.filteredMovies = self.movies.filter({ (text) -> Bool in
            let tmp: NSString = (text.name! as NSString?)!
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if searchText == "" {
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
