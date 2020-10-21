//
//  FavsViewController.swift
//  app
//
//  Created by rfl3 on 15/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import UIKit

class FavsViewController: UIViewController {

    // Variables
    var movies: [Movie] = []

    // Components
    let screen = FavsViewControllerView()

    override func loadView() {
        self.view = screen
    }

    override func viewDidLoad() {
        self.screen.collectionView.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.screen.collectionView.delegate = self
        self.screen.collectionView.dataSource = self

        self.movies = CoreDataService.shared.fetchFavorites() ?? []

        NotificationCenter.default.addObserver(self, selector: #selector(self.updateFavorites(_:)), name: NSNotification.Name("FavoritesUploaded"), object: nil)

        DispatchQueue.main.async {
            self.screen.collectionView.reloadData()
        }
    }

    @objc
    func updateFavorites(_ notification: NSNotification) {
        self.movies = CoreDataService.shared.fetchFavorites() ?? self.movies
        DispatchQueue.main.async {
            self.screen.collectionView.reloadData()
        }
    }
    
}

extension FavsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.screen.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GridCollectionViewCell
        cell.movie = self.movies[indexPath.row]
        return cell
    }


}

extension FavsViewController: UICollectionViewDelegate {

}
