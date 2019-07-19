//
//  ViewController.swift
//  Mov
//
//  Created by Victor Leal on 18/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let screen = MoviesViewControllerScreen()
    
    
    
    override func loadView() {
        
        self.view = screen
        self.view.backgroundColor = .green
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screen.movieCollectionView.delegate = self
        screen.movieCollectionView.dataSource = self
     
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = screen.movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! FreelancerCell
        
        cell.backgroundColor = .yellow
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    
}


class MoviesViewController22: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
   //let screen = MoviesViewControllerScreen()
    let searchController = UISearchController(searchResultsController: nil)
    
    let movies = ["AAA", "BBB", "CCC", "DDD", "FFF"]
    
    override func loadView() {
     //   let layout = UICollectionViewFlowLayout()
     //   layout.scrollDirection = .vertical
     //   screen.movieCollectionView.setCollectionViewLayout(layout, animated: true)
        
       // self.view = screen
       // self.view.backgroundColor = .green
        
       // setupSearchController()
    }
    
    var collectionview: UICollectionView!
    var cellId = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // screen.movieCollectionView.delegate = self
      //  screen.movieCollectionView.dataSource = self
        
        
        
        
        
        // Create an instance of UICollectionViewFlowLayout since you cant
        // Initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 700)
        
        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(FreelancerCell.self, forCellWithReuseIdentifier: cellId)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor.white
        self.view.addSubview(collectionview)
        
        
        


    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FreelancerCell
        
        cell.backgroundColor = .yellow
        
        return cell
        
    }
    
   
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

extension MoviesViewController: UISearchResultsUpdating {
    
  /*  func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = UIColor(red:0.18, green:0.19, blue:0.27, alpha:1.00)
        navigationItem.searchController = searchController
        definesPresentationContext = true
    } */
    
    
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






class FreelancerCell: UICollectionViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.text = "Bob Lee"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        backgroundColor = UIColor.black
        
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
        }
        
    }
    
    
    
}

