//
//  PopularMoviesVC.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import UIKit

class PopularMoviesVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    internal lazy var viewModel: PopularMoviesViewModel = {
        let vm = PopularMoviesViewModel()
        vm.setView(self)
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let flowLayout = CollectionViewFlowLayout()
        flowLayout.flowDelegate = self
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.register(MovieGridCell.self)
        
    }

}

extension PopularMoviesVC: UICollectionViewDelegate {
    
}

extension PopularMoviesVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieGridCell = collectionView.dequeue(for: indexPath)
        
        return cell
    }
}

extension PopularMoviesVC: CollectionViewFlowLayoutDelegate {
    
    func numberOfColumns() -> Int {
        return 2
    }
    
    func height(at indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension PopularMoviesVC: PopularMoviesDelegate {
    
    func reloadData() {
        
    }
    
}

