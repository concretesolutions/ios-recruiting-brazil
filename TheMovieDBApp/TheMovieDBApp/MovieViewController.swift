//
//  MovieViewController.swift
//  TheMovieDB
//
//  Created by Gustavo Quenca on 31/10/18.
//  Copyright © 2018 Quenca. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let dataSource = DataSource()
    
    var searchController = UISearchController(searchResultsController: nil)
    
    // A dictionary of offscreen cells that are used within the sizeForItemAtIndexPath method to handle the size calculations. These are never drawn onscreen. The dictionary is in the format:
    // { NSString *reuseIdentifier : UICollectionViewCell *offscreenCell, ... }
    var offscreenCells = Dictionary<String, UICollectionViewCell>()
    
    let kHorizontalInsets: CGFloat = 10.0
    let kVerticalInsets: CGFloat = 10.0
    
    struct CollectionViewCellIdentifiers {
        static let movieCell = "MovieCollectionViewCell"
        static let nothingFoundCell = "NothingFoundCollectionViewCell"
        static let loadingCell = "LoadingCollectionViewCell"
    }

    weak var delegate: UISearchControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        // Setup the Collection View
        collectionView.register(UINib(nibName: CollectionViewCellIdentifiers.movieCell, bundle: .main), forCellWithReuseIdentifier: CollectionViewCellIdentifiers.movieCell)
        
        collectionView.register(UINib(nibName: CollectionViewCellIdentifiers.loadingCell, bundle: .main), forCellWithReuseIdentifier: CollectionViewCellIdentifiers.loadingCell)
        
        collectionView.register(UINib(nibName: CollectionViewCellIdentifiers.nothingFoundCell, bundle: .main), forCellWithReuseIdentifier: CollectionViewCellIdentifiers.nothingFoundCell)
    
        // Get the request for the popular movies
        dataSource.getRequest(completion: { success in
            if !success {
                print("error")
            }
            self.collectionView.reloadData()
        })
    }
    
    func setupNavigationBar() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = false
        searchController.searchBar.placeholder = "Search Movie"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
    }
}

// MARK: -Setting the SerchBar
extension MovieViewController: UISearchBarDelegate {
    
    // Return the Popular Movies of your SerchBar
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        dataSource.getSerchRequest(for: searchBar.text!, completion: { success in
            if !success {
                print("error")
            }
            self.collectionView.reloadData()
        })

        if searchBar.text!.isEmpty {
            dataSource.getRequest(completion: { success in
                if !success {
                    print("error")
                }
                print("SEARCH")
                self.collectionView.reloadData()
            })
        }
    }
    
    // Return the Popular Movies after cancel the Search
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dataSource.getRequest(completion: { success in
            if !success {
                print("error")
            }
            self.collectionView.reloadData()
            print("RELOAD")
        })
    }
}

extension MovieViewController: UISearchResultsUpdating {
    
    // Update the Search
    func updateSearchResults(for searchController: UISearchController) {
        print("UPDADE \(searchController.searchBar.text!)")
        dataSource.getSerchRequest(for: searchController.searchBar.text!, completion: { success in
            if !success {
                print("error")
            }
            self.collectionView.reloadData()
        })
        
    // Return the Popular Movies if there is no Search
        if searchController.searchBar.text!.isEmpty {
            dataSource.getRequest(completion: { success in
                if !success {
                    print("error")
                }
                print("---- UPDATE")
                self.collectionView.reloadData()
            })
        }
    }
}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: -Setting the Collection Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Set up desired width
        let targetWidth: CGFloat = (self.collectionView.bounds.width - 3 * kHorizontalInsets) / 2
        
        // Use fake cell to calculate height
        let reuseIdentifier =  CollectionViewCellIdentifiers.movieCell
        var cell: MovieCollectionViewCell? = self.offscreenCells[reuseIdentifier] as? MovieCollectionViewCell
        if cell == nil {
            if let cells = Bundle.main.loadNibNamed("MovieCollectionViewCell", owner: self, options: nil), let c = cells[0] as? MovieCollectionViewCell {
                cell = c
                self.offscreenCells[reuseIdentifier] = c
            }
        }
        
        // Cell's size is determined in nib file, need to set it's width (in this case), and inside, use this cell's width to set label's preferredMaxLayoutWidth, thus, height can be determined, this size will be returned for real cell initialization
        cell!.bounds = CGRect(x: 0, y: 0, width: targetWidth, height: cell!.bounds.height)
        cell!.contentView.bounds = cell!.bounds
        
        // Layout subviews, this will let labels on this cell to set preferredMaxLayoutWidth
        cell!.layoutIfNeeded()
        
        var size = cell!.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        // Still need to force the width, since width can be smalled due to break mode of labels
        size.width = targetWidth
        return size
        //let width = (view.frame.size.width - 10) / 2.0
        //return CGSize(width: width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: kVerticalInsets, left: kHorizontalInsets, bottom: kVerticalInsets, right: kHorizontalInsets)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return kHorizontalInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return kVerticalInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch dataSource.state {
        case .notSearchedYet:
            return 0
        case .loading:
            return 1
        case .noResults:
            return 1
        case .results(let list):
            return list.results?.count ?? 0
        }
    }
    
    // Mark: -CollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Collection view cellForRowAt")
        
        switch dataSource.state {
        case .notSearchedYet:
            fatalError("Should never get here")
            
        case .loading:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.loadingCell, for: indexPath) as! LoadingCollectionViewCell
            return cell
            
        case .noResults:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.nothingFoundCell, for: indexPath) as! NothingFoundCollectionViewCell
            return cell
            
        case .results(let list):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.movieCell, for: indexPath) as! MovieCollectionViewCell
            
            let movieResult = list.results?[indexPath.row]
            cell.configure(for: (movieResult ?? nil)!)
            cell.layoutIfNeeded()
            return cell
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if case .results(let list) = dataSource.state {
            let movieDetail = MovieDetailViewController()
            movieDetail.selectedMovie? = list.results![indexPath.row]
            performSegue(withIdentifier: "MovieDetail", sender: indexPath)
        }
    }
    
    // MARK: -Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieDetail" {
            if case .results(let list) = dataSource.state {
                let detailViewController = segue.destination as! MovieDetailViewController
                let indexPath = sender as! IndexPath
                let searchResult = list.results?[indexPath.row]
                detailViewController.selectedMovie = searchResult
            }
        }
    }
}
