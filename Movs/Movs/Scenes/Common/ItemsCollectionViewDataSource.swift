//
//  ItemsCollectionViewDataSource.swift
//  Movs
//
//  Created by Brendoon Ryos on 04/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit

protocol ItemsCollectionViewDataSource: UICollectionViewDataSource {
  associatedtype T
  var items:[T] { get }
  var collectionView: UICollectionView? { get }
  var delegate: UICollectionViewDelegate? { get }
  
  init(collectionView: UICollectionView, delegate: UICollectionViewDelegate)
  
  func setupCollectionView()
  func registerCollection()
}

extension ItemsCollectionViewDataSource {
  func setupCollectionView() {
    registerCollection()
    self.collectionView?.dataSource = self
    self.collectionView?.delegate = self.delegate
  }
  
  func registerCollection() {
    
  }
}
