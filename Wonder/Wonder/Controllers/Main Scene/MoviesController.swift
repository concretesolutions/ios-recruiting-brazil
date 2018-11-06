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

class MoviesController: UIViewController, UISearchBarDelegate {

    // MARK: - Properties
    private var search = UISearchController()
    private var searchInProgress = false
    private var searchArgument = String()
    
    
    
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
            performSegue(withIdentifier: "showErrorHandler", sender: self)
        }else{
            AppSettings.standard.updateInternetConnectionStatus(true)

//            self.setNoContent(msg: "Loading...")
//            self.setActivityIndicator(show: true)
//            loadAppData()
            
            // post notification to error hanlder to dismiss UI
            NotificationCenter.default.post(name: Notification.Name("didConnectToInternet"), object: nil, userInfo: nil)
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
    
}
