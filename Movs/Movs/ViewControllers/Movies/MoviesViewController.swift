//
//  MoviesViewController.swift
//  Movs
//
//  Created by Dielson Sales on 29/09/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    enum Constants {
        static let nibName = "MoviesViewController"
        static let title = "Movies"
        static let cellIdentifier = "MoviesCollectionViewCell"
        static let cellSpacing: CGFloat = 5.0
    }

    @IBOutlet var popularCollectionView: UICollectionView!

    private var presenter: MoviesPresenter!

    init() {
        super.init(nibName: Constants.nibName, bundle: nil)
        title = Constants.title
        tabBarItem.title = Constants.title
        tabBarItem.image = UIImage(named: "tabItemList")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MoviesPresenter()
        presenter.view = self
        setupCollectionView()
    }

    private func setupCollectionView() {
        popularCollectionView.register(
            UINib(nibName: Constants.cellIdentifier, bundle: nil),
            forCellWithReuseIdentifier: Constants.cellIdentifier
        )
        popularCollectionView.contentInset = UIEdgeInsets(
            top: Constants.cellSpacing,
            left: Constants.cellSpacing,
            bottom: Constants.cellSpacing,
            right: Constants.cellSpacing
        )
        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
    }
}

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moviesCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellIdentifier,
            for: indexPath
        )
        if let cell = moviesCell as? MoviesCollectionViewCell {
            // TODO: setup cell
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        presenter.onMovieSelected()
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width / 2) - 8
        return CGSize(width: cellWidth, height: cellWidth + 30)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.cellSpacing
    }
}

extension MoviesViewController: MoviesView {
    func openMovieDetails() {
        let movieDetailsViewController = MovieDetailsViewController()
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}
