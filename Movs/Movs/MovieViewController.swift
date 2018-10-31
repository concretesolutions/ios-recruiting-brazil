//
//  MovieViewController.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 30/10/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, UISearchResultsUpdating{
  
  var filteredTem = [String]()
  
  lazy var collectionView: UICollectionView = {
    let flowLayout =  UICollectionViewFlowLayout()
    let collection = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
    collection.backgroundColor = .blue
    collection.translatesAutoresizingMaskIntoConstraints = false
    collection.dataSource = self
    collection.delegate = self
    collection.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "movieCell")
    return collection
  }()

  func updateSearchResults(for searchController: UISearchController) {
    filteredTem =  teste.filter { (team) -> Bool in
      if team.lowercased().range(of: searchController.searchBar.text!) != nil {
        return true
      }
      return false
    }
    print(filteredTem)
    
  }
  
  var teste: [String] = ["oi", "alo", "como vc está?", "nada bem"]
  
   func setupCollection() {
    view.addSubview(collectionView)
    collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
  override func loadView() {
    self.view = ContainerView(frame: UIScreen.main.bounds)
    let searchController = UISearchController(searchResultsController: nil)
    navigationItem.searchController = searchController
    navigationItem.searchController?.searchResultsUpdater = self
    navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
    navigationItem.searchController?.dimsBackgroundDuringPresentation = false
    definesPresentationContext = true
    setupCollection()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

}

extension MovieViewController: UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 30
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath)
//    cell.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
    cell.backgroundColor = .black
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 200, height: 200)
  }
  
}
