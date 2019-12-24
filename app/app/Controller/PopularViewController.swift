//
//  PopularViewController.swift
//  app
//
//  Created by rfl3 on 23/12/19.
//  Copyright © 2019 Renan Freitas. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController {
    
    var selectedMovie: Movie?
    var allMovies: [Movie] = []
    var movies: [Movie] = []
    var genres: [Int: String] = [:]
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searching = false
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
    }
    
    override func viewDidLoad() {
        self.searchBar.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedOutsideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        RequestService.shared.delegate = self
        RequestService.shared.getMovies()
        RequestService.shared.getGenres()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detail" {
            //swiftlint:disable force_cast
            let detailVC = segue.destination as! DetailViewController
            detailVC.delegate = self
            //swiftlint:enable force_cast
            detailVC.movie = self.selectedMovie
            detailVC.genres = self.genres
        }
        
    }
    
}


extension PopularViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row > self.movies.count - 4 && !self.searching {
            RequestService.shared.getMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // I'm sure it's castable
        // swiftlint:disable force_cast
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "cell",
                                 for: indexPath) as! PopularCollectionViewCell
        // swiftlint:enable foce_cast
        
        cell.movie = self.movies[indexPath.row]
        
        return cell
    }
}

extension PopularViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedMovie = self.movies[indexPath.row]
        performSegue(withIdentifier: "detail", sender: self)
    }
}

extension PopularViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 0.4301 * self.view.frame.width
        return CGSize(width: width,
                      height: width * 1.5056)
    }
}

extension PopularViewController: RequestServiceDelegate {
    
    func didReceiveMovie(_ movie: Movie) {
    }
    
    func didReceiveData(_ movies: [Movie]) {
        self.allMovies += movies
        self.movies = allMovies
        DispatchQueue.main.async {
            self.popularCollectionView.reloadData()
        }
    }
    
    func didReceiveGenres(_ genres: [Int : String]) {
        self.genres = genres
    }
    
}

extension PopularViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searching = true
        if searchText == "" {
            self.movies = self.allMovies
        } else {
            self.movies = self.allMovies.filter({ $0.title.lowercased().contains(searchText.lowercased()) })
        }
        self.popularCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.enablesReturnKeyAutomatically = false;
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            searchBar.resignFirstResponder()
            self.searching = false
            self.movies = self.allMovies
            self.popularCollectionView.reloadData()
        } else {
            searchBar.resignFirstResponder()
        }
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @objc func tappedOutsideKeyboard() {
        self.searchBar.endEditing(true)
    }
        
}

extension PopularViewController: DetailViewControllerDelegate {
    func didChangeMovie(_ id: Int, _ favorite: Bool) {
        for i in 0..<self.movies.count where self.movies[i].id == id {
            self.movies[i].favorite = favorite
        }
        self.popularCollectionView.reloadData()
    }
}
