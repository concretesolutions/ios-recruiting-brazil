//
//  MoviesGridController.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
class MoviesGridController: UIViewController {
    private let customView = MoviesGridView()
//    let dataSource = MoviesGridDataSource()
    var movies = [MovieDTO]() {
        didSet {
            DispatchQueue.main.async {
                self.customView.grid.reloadData()                
            }
        }
    }

    override func loadView() {
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.grid.dataSource = self
        customView.grid.delegate = self
        setNavigation()
        requestMovies()
    }

    private func setNavigation() {
        self.title = "Movies"
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .yellow
        self.navigationController?.navigationBar.backgroundColor = .yellow
    }

    private func requestMovies() {
        let service = MovieService.getTrendingMovies
        let session = URLSessionProvider()
        session.request(type: MoviesResultDTO.self, service: service) { (result) in
            switch result {
            case .success(let result):
                self.movies = result.movies
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MoviesGridController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screeSize = UIScreen.main.bounds
        let cellWidth = screeSize.width/2 - 20
        let cellHeight = cellWidth * 1.5
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
