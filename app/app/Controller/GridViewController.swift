//
//  GridViewController.swift
//  app
//
//  Created by rfl3 on 15/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {

    // Variables
    var movies: [Movie] = []

    // Components
    let screen = GridViewControllerView()

    override func loadView() {
        self.view = self.screen
        
    }

    override func viewDidLoad() {

        self.screen.collectionView.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.screen.collectionView.delegate = self
        self.screen.collectionView.dataSource = self

        APIService.shared.requestPopular { moviesResult in
            guard let movies = moviesResult else { return }
            self.movies += movies
            DispatchQueue.main.async {
                self.screen.collectionView.reloadData()
            }
        }
    }

}

extension GridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.screen.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GridCollectionViewCell
        cell.movie = self.movies[indexPath.row]
        return cell
    }


}

extension GridViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.movies.count - 3 {
            APIService.shared.requestPopular { moviesResult in
                guard let movies = moviesResult else { return }
                self.movies.append(contentsOf: movies)
                DispatchQueue.main.async {
                    self.screen.collectionView.reloadData()
                }
            }
        }
    }
}
