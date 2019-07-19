//
//  ViewController.swift
//  Mov
//
//  Created by Victor Leal on 18/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let screen = MoviesViewControllerScreen()
    let searchController = UISearchController(searchResultsController: nil)
    
    let movies = ["AAA", "BBB", "CCC", "DDD", "FFF"]
    
    override func loadView() {
     //   let layout = UICollectionViewFlowLayout()
     //   layout.scrollDirection = .vertical
     //   screen.movieCollectionView.setCollectionViewLayout(layout, animated: true)
        
        self.view = screen
        self.view.backgroundColor = .green
        
        setupSearchController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        screen.movieCollectionView.delegate = self
        screen.movieCollectionView.dataSource = self
        
        
        


    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath)
        
    
        
        cell.backgroundColor = .yellow
        
        return cell
        
    }
    
   
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

extension MoviesViewController: UISearchResultsUpdating {
    
    func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = UIColor(red:0.18, green:0.19, blue:0.27, alpha:1.00)
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        // https://www.raywenderlich.com/472-uisearchcontroller-tutorial-getting-started
    }
}




class VideoCollectionViewCell:UICollectionViewCell {
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .lightGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2/3, constant: -10).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2, constant: -10).isActive = true
    }
}
