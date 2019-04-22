//
//  BookmarksViewController.swift
//  Concrete
//
//  Created by Vinicius Brito on 20/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import UIKit

class BookmarksViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    var viewModelData: [MovieViewModel]? = []

    @IBOutlet weak var collectionViewMovies: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewMovies.register(UINib(nibName: "MovieCell", bundle: .main),
                                      forCellWithReuseIdentifier: "movieCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }

    private func fetchData() {

        let arrayResult = DBManager.sharedInstance.getBookmarkItens()
        if !arrayResult.isEmpty {
            setViewModel(response: arrayResult)
        } else {
            viewModelData = []
            collectionViewMovies.reloadData()
        }
    }

    func setViewModel(response: [Result]) {
        let movies = response
        viewModelData = movies.map({ return MovieViewModel(item: $0)})
        collectionViewMovies.reloadData()
    }

    @objc func bookmark(_ sender: UIButton) {
        if let idMovie = viewModelData?[sender.tag].idMovie {
            if DBManager.sharedInstance.changeBookmarkedItemFromKey(pKey: idMovie) {}
            self.collectionViewMovies.reloadData()
        }
    }
}

extension BookmarksViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewMovies.frame.width / 2 - 15,
                      height: collectionViewMovies.frame.width / 2 + 45)
    }
}

extension BookmarksViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if let count = viewModelData?.count {
            return count
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell",
                                                         for: indexPath) as? MovieCell {
            if let cellData = viewModelData?[indexPath.row] {
                cell.setCellData(cellData: cellData)
                cell.buttonStar.tag = indexPath.row
                cell.buttonStar.addTarget(self, action: #selector(bookmark(_:)), for: .touchUpInside)
            }

            return cell
        }

        return MovieCell()
    }
}

extension BookmarksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = viewModelData?[indexPath.row] {
            coordinator?.createDetails(to: movie)
        }
    }
}
