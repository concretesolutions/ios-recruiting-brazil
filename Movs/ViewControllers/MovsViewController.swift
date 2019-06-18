//
//  MovsViewController.swift
//  Movs
//
//  Created by Filipe on 17/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class MovsViewController: UIViewController {
    
    @IBOutlet weak var movTabBarItem: UITabBarItem!
    @IBOutlet weak var movCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movCollectionView.dataSource = self
        movCollectionView.delegate = self
        movTabBarItem.selectedImage = (UIImage(named: "list_icon"))
    }

}
// MARK: - UICollectionViewDataSource
extension MovsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mcell", for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
}
// MARK: - UICollectionViewDelegate
extension MovsViewController: UICollectionViewDelegate {

}
