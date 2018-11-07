//
//  MoviesController.swift
//  Wonder
//
//  Created by Marcelo on 06/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

// reachability
var reachability = Reachability(hostname: "www.apple.com")

class MoviesController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    

    // MARK: - outlets
    @IBOutlet var errorHandlerView: UIView!
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    
    // MARK: - Properties
    private var search = UISearchController()
    private var searchInProgress = false
    private var searchArgument = String()
    
    private var source = ["One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four"]

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Config
        uiConfig()
        
        // observers
        observerManager()
        
        // Check internet status
        checkInternetStatus()
        
    }
    

    // MARK: - UI Config
    private func uiConfig() {
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        // Navigation Search
        search = UISearchController(searchResultsController: nil)
        search.searchBar.delegate = self
        search.searchResultsUpdater = self as? UISearchResultsUpdating
        search.searchBar.tintColor = UIColor.black
        
        // search text field background color
        if let textfield = search.searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {
                
                // Background color
                backgroundview.backgroundColor = UIColor.white
                
                // Rounded corner
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
        
        // associate to navigation item
        self.navigationItem.searchController = search
        
    }
    
    
    
    // MARK: - Observers
    private func observerManager() {
        
        //
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityStatusChanged(_:)),
                                               name: NSNotification.Name(rawValue: "ReachabilityChangedNotification"),
                                               object: nil)
        
        
        
    }
    
    // observer actions
    // rawValue: ReachabilityChangedNotification)
    @objc private func reachabilityStatusChanged(_ sender: NSNotification) {
        
        guard ((sender.object as? Reachability)?.currentReachabilityStatus) != nil else { return }
        
        checkInternetStatus()
        
    }
    
    private func checkInternetStatus() {
        if !reachability.isReachable() {
            AppSettings.standard.updateInternetConnectionStatus(false)
            
            view.showErrorView(errorHandlerView: self.errorHandlerView, errorType: .internet, errorMessage: "Oops! Looks like you have no conection to the internet!")
            
//            view.showErrorView(errorHandlerView: self.errorHandlerView, errorType: .business, errorMessage: "Search argument not found!")
            
//            view.showErrorView(errorHandlerView: self.errorHandlerView, errorType: .loading, errorMessage: "Loading...")
            
        }else{
            AppSettings.standard.updateInternetConnectionStatus(true)
            
//            loadAppData()
            
            view.hideErrorView(view: view)
            
            // post notification to error hanlder to dismiss UI
//            NotificationCenter.default.post(name: Notification.Name("didConnectToInternet"), object: nil, userInfo: nil)
        }
    }

    // MARK: - UISearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
//        self.search.setEditing(true, animated: true)
//        self.searchInProgress = true
//        self.searchArgument = (searchBar.text?.trim())!
//        //
//        navigationController?.navigationBar.isHidden = true
//        if #available(iOS 11.0, *) {
//            navigationController?.navigationBar.prefersLargeTitles = false
//        } else {
//            // Fallback on earlier versions
//        }
//        self.search.isActive = false
//        //
//
//        self.performSegue(withIdentifier: "showSearchScene", sender: self)
//
//    }
    
//    @objc private func didSelectBarBackAction() {
//
//        // reinstantiate scene
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateInitialViewController()
//        UIApplication.shared.keyWindow?.rootViewController = vc
//
//
    }
 
    
    // MARK: - UICollectionView Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.count
    }
    
    // MARK: - UICollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.green
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  16
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    
    
    
    
}
