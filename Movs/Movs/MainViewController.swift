//
//  MainViewController.swift
//  Movs
//
//  Created by Marcos Fellipe Costa Silva on 30/10/2018.
//  Copyright © 2018 Marcos Fellipe Costa Silva. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
  lazy var collection: UICollectionView = {
    let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    cv.dataSource = self
    cv.delegate = self
    cv.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "banana")
    cv.backgroundColor = UIColor.purple
    return cv
  }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      view.addSubview(collection)
      collection.translatesAutoresizingMaskIntoConstraints = false
      collection.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
      collection.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
      collection.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
      collection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(withReuseIdentifier: "banana", for: indexPath)
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
