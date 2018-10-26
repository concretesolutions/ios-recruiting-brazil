//
//  MoviesViewController.swift
//  Challenge
//
//  Created by Sávio Berdine on 22/10/18.
//  Copyright © 2018 Sávio Berdine. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [Movie] = []
    
    //Using didset to controll the search results on time and show the error message if necessary
    var filteredMovies: [Movie] = [] {
        didSet {
            self.updateView()
        }
    }
    var page = 1
    var searchActive = false
    var searchText: String = ""
    
    //Configuring the Tab bar icon
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let image = UIImage(named: "list_icon")
        image?.draw(in: CGRect(x: 0, y: 0, width: 0, height: 0))
        tabBarItem = UITabBarItem(title: "Movies", image: image, tag: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchBar.delegate = self
        handlePagination()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    func updateView() {
        let hasSearchResult = self.filteredMovies.count > 0
        self.collectionView.isHidden = !hasSearchResult && !(self.searchBar.text?.isEmpty)!
        if !hasSearchResult && !(self.searchBar.text?.isEmpty)! {
            print("No result in the search")
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //This function handles pagination and asks to the model for the proper amount of data
    @objc func handlePagination() {
        print("Handling pagination")
        //Requesting the popular movies and the users favorites, to mark them as favorites on frontend
        Movie.getPopularMovies(pageToRequest: self.page, onSuccess: { (moviesResult) in
            Movie.getFavoriteMovies(pageToRequest: self.page, onSuccess: { (favoriteMoviesResult) in
                var i = 0
                for movie in moviesResult {
                    movie.isFavourite = false
                    moviesResult[i].isFavourite = false
                    for favorite in favoriteMoviesResult {
                        if movie.id == favorite.id {
                            movie.isFavourite = true
                            moviesResult[i].isFavourite = true
                        }
                    }
                    i += 1
                }
                self.movies.append(contentsOf: moviesResult)
                self.page += 1
                self.collectionView.reloadData()
            }, onFailure: { (error) in
                print(error)
            })
        }) { (error) in
            print(error)
        }
    }
    
    //This function detects when the user get to the end of the tableview, collectionview (or any scrollview child class) and swip up. So the hadlePagination() function is called
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentOffset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.height
        if maxOffset - currentOffset <= 40 {
            self.handlePagination()
        }

    }
    
    //Collectionview Setup
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/2.0
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.searchActive {
            return self.filteredMovies.count
        }
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MoviesCollectionViewCell
        //If the search is active, the data source is a different array
        if self.searchActive {
            cell.label.text = self.filteredMovies[indexPath.row].name
            
            //Using cache with the apps images to reduce memory and internet consumption
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280/\(String(describing: self.filteredMovies[indexPath.row].imagePath!))"))
        } else {
            cell.label.text = self.movies[indexPath.row].name
            //Using cache with the apps images to reduce memory and internet consumption
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280/\(String(describing: self.movies[indexPath.row].imagePath!))"))
        }
        
        return cell
    }
    
    private func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: MoviesCollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.imageView.kf.cancelDownloadTask()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "moviesToDetails", sender: nil)
    }
    
    //SearchBar steup
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
        
        //Filtering "on demmand". (As the user types)
        self.filteredMovies = self.movies.filter({ (text) -> Bool in
            let tmp: NSString = (text.name! as NSString?)!
            self.searchText = tmp as String
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        
        //Seting the searchActive flag.
        if(self.filteredMovies.isEmpty) {
            self.searchActive = false
        } else {
            self.searchActive = true
        }
        self.collectionView.reloadData()
    }
    
    //Default error alert
    func errorAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moviesToDetails" {
            let vc = segue.destination as! MovieDetailsViewController
            if let itemIndex = self.collectionView.indexPathsForSelectedItems?.first?.item, let indexPath = self.collectionView.indexPathsForSelectedItems?.first{
                
                //Passing the object from the right datasource to the next view
                if self.searchActive {
                    vc.movie = self.filteredMovies[itemIndex]
                } else {
                    vc.movie = self.movies[itemIndex]
                }
                let cell = self.collectionView.cellForItem(at: indexPath) as! MoviesCollectionViewCell
                vc.image = cell.imageView?.image
                self.collectionView.deselectItem(at: indexPath, animated: false)
            }
            
        }
    }
    

}
