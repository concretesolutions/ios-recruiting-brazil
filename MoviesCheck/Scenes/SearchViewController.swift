//
//  SearchViewController.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 26/10/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var mediaCollectionView: UICollectionView!
    @IBOutlet var loadingView: UIView!
    
    //Type for the search of the current ViewController
    var searchType:ScreenType? = nil
    
    var searchManager:SearchDataManager?
    
    var selectedMediaItem:MediaItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Manager for the the SearchBar, JsonLoader and CollectionView
        if let type = searchType{
            
            searchManager = SearchDataManager(type: type)
            
            searchBar.delegate = searchManager
            mediaCollectionView.delegate = searchManager
            mediaCollectionView.dataSource = searchManager
            
            searchManager?.delegate = self
            searchManager?.dataSource = self
            
            if(type == .movies){
                title = "Search Movies"
            }else{
                title = "Search TV Shows"
            }
            
        }
        
        //SearchBar configuration
        searchBar.setTextColor(color: UIColor.white)
        
        //Add loading view
        self.view.addSubview(loadingView)
        setupVisualLanguageConstraints()
        
        //Hide loading view by default
        loadingView.isHidden = true
        
        //Show popular Movies or Tv Shows
        searchManager?.requestPopularMedia()
        
    }
    
    /**
     Add 4 constraints generated using visual language 2 horizontal and 2 vertical
     */
    func setupVisualLanguageConstraints(){
        
        var topTraillingSpace = CGFloat(4)
        var bottomTraillingSpace = CGFloat(4)
        
        //Adding top safe area size to top trailling constraint
        if let topSafeAreaHeight = UIApplication.shared.keyWindow?.safeAreaInsets.top{
            topTraillingSpace += topSafeAreaHeight
        }
        
        if let topNavigationBarHeight = navigationController?.navigationBar.frame.size.height{
            topTraillingSpace += topNavigationBarHeight
        }
        
        if let bottomTabbarHeight = tabBarController?.tabBar.frame.size.height{
            bottomTraillingSpace += bottomTabbarHeight
        }
        
        //Visual Language Constraints
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        let myViews = ["spinnerView":loadingView]
        
        let constraintsHorizontais = NSLayoutConstraint.constraints(withVisualFormat: "H:|-4-[spinnerView]-4-|", options: [], metrics: nil, views: myViews as Any as! [String : Any])
        
        let constraintsVerticais = NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(topTraillingSpace)-[spinnerView]-\(bottomTraillingSpace)-|", options: [], metrics: nil, views: myViews as Any as! [String : Any])
        
        NSLayoutConstraint.activate(constraintsHorizontais)
        NSLayoutConstraint.activate(constraintsVerticais)
    }
    
    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == AppSegues.mediaDetail.rawValue{
            
            let destinationViewController = segue.destination as! MediaDetailViewController
            destinationViewController.searchType = searchType
            destinationViewController.mediaItem = selectedMediaItem
            
        }
        
     }
    
    
}

extension SearchViewController: SearchDataManagerDelegate, SearchDataManagerDataSource{
    
    //MARK:- SearchDataManagerDelegate
    func shouldRealoadData() {
        DispatchQueue.main.async {
            self.mediaCollectionView.reloadData()
        }
    }
    
    func displayLoadingIndicator() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = false
        }
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
        }
    }
    
    func mediaItemSelected(item: MediaItem) {
        
        selectedMediaItem = item
        performSegue(withIdentifier: AppSegues.mediaDetail.rawValue, sender: nil)
        
    }
    
    //MARK:- SearchDataManagerDataSource
    func getViewSize() -> CGSize {
        return view.frame.size
    }
    
}
