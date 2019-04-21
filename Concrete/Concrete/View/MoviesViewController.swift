//
//  ViewController.swift
//  Concrete
//
//  Created by Vinicius Brito on 20/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, Storyboarded {

    @IBOutlet weak var collectionViewMovies: UICollectionView!

    weak var coordinator: MainCoordinator?
    private var isLoading = false
    private let serviceManager = MoviesService()
    var viewModelData: [MovieViewModel]? = []
    private var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        fetchData(page: 1)

        self.collectionViewMovies.register(UINib(nibName: "MovieCell", bundle: .main),
                                         forCellWithReuseIdentifier: "movieCell")
    }

    private func showAlertInternet() {

    }

    private func fetchData(page: Int) {
        if Reachability.isConnectedToNetwork() {
            self.isLoading = true
            serviceManager.loadMovies(page: "\(page)") { (response, _) in
                if response != nil {
                    print(response as Any)
                    self.setViewModel(response: response)
                } else {
                    print("error")
                }
                self.isLoading = false
            }
        } else {
            showAlertInternet()
        }
    }

    func setViewModel(response: Movies?) {

        if let count = viewModelData?.count {
            if count == 0 {
                if let movies = response?.results {
                    viewModelData = movies.map({ return MovieViewModel(item: $0)})
                }
            } else {
                if let movies = response?.results {
                    viewModelData?.append(contentsOf: movies.map({
                        return MovieViewModel(item: $0) }))
                }
            }
        }

        self.collectionViewMovies.reloadData()
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionViewMovies.frame.width / 2 - 17,
                      height: self.collectionViewMovies.frame.width / 2 - 17)
    }
}

extension MoviesViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if let count = self.viewModelData?.count {
            return count
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell",
                                                         for: indexPath) as? MovieCell {
            if let cellData = self.viewModelData?[indexPath.row] {
                cell.setCellData(cellData: cellData)
            }

            return cell
        }

        return MovieCell()
    }
}
