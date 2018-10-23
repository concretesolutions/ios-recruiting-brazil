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
    var filteredMovies: [Movie] = [] {
        didSet {
            self.updateView()
        }
    }
    var page = 1
    var searchActive = false
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        self.collectionView.addSubview(self.refreshControl)
        
        return refreshControl
    }()
    
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
        self.collectionView.isHidden = !hasSearchResult
        if !hasSearchResult {
            print("No result in the search")
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func handlePagination() {
        print("Handling pagination")
        Movie.getPopularMovies(pageToRequest: self.page, onSuccess: { (moviesResult) in
            self.movies.append(contentsOf: moviesResult)
            self.page += 1
            self.collectionView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("Handling refresh")
        self.page = 1
        handlePagination()
        self.collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentOffset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.height
        if maxOffset - currentOffset <= 40 {
            self.handlePagination()
        }

    }
    
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
        if self.searchActive ?? false {
            return self.filteredMovies.count
        }
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MoviesCollectionViewCell
        if self.searchActive ?? false {
            cell.label.text = self.filteredMovies[indexPath.row].name
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280/\(String(describing: self.filteredMovies[indexPath.row].imagePath!))"))
        } else {
            cell.label.text = self.movies[indexPath.row].name
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
        if(self.filteredMovies.isEmpty) {
            self.searchActive = false
        } else {
            self.searchActive = true
        }
        self.collectionView.reloadData()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moviesToDetails" {
            let vc = segue.destination as! MovieDetailsViewController
            if let itemIndex = self.collectionView.indexPathsForSelectedItems?.first?.item, let indexPath = self.collectionView.indexPathsForSelectedItems?.first{
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
