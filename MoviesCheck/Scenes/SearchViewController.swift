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
    
    var searchManager:SearchPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Presenter that manages the SearchBar, JsonLoader and CollectionView
        if let type = searchType{
            
            searchManager = SearchPresenter(type: type)
            
            searchBar.delegate = searchManager
            mediaCollectionView.delegate = searchManager
            mediaCollectionView.dataSource = searchManager
            
            searchManager?.delegate = self
            searchManager?.dataSource = self
            
        }
        
        //SearchBar configuration
        searchBar.setTextColor(color: UIColor.white)
        
        //Add loading view
        self.view.addSubview(loadingView)
        setupVisualLanguageConstraints()
        
        //Hide loading view by default
        loadingView.isHidden = true
        
    }
    
    /**
     Add 4 constraints generated using visual language 2 horizontal and 2 vertical
     */
    func setupVisualLanguageConstraints(){
        
        //Visual Language Constraints
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        let myViews = ["spinnerView":loadingView]
        
        let constraintsHorizontais = NSLayoutConstraint.constraints(withVisualFormat: "H:|-7-[spinnerView]-6-|", options: [], metrics: nil, views: myViews as Any as! [String : Any])
        
        let constraintsVerticais = NSLayoutConstraint.constraints(withVisualFormat: "V:|-76-[spinnerView]-6-|", options: [], metrics: nil, views: myViews as Any as! [String : Any])
        
        NSLayoutConstraint.activate(constraintsHorizontais)
        NSLayoutConstraint.activate(constraintsVerticais)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension SearchViewController: SearchPresenterDelegate, SearchPresenterDataSource{
    
    //MARK:- SearchPresenterDelegate
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
    
    //MARK:- SearchPresenterDataSource
    func getViewSize() -> CGSize {
        return view.frame.size
    }
    
}
