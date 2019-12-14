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
    let dataSource = MoviesGridDataSource()

    override func loadView() {
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.grid.dataSource = dataSource
        customView.grid.delegate = self
        setNavigation()
    }

    func setNavigation() {
        self.title = "Movies"
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .yellow
        self.navigationController?.navigationBar.backgroundColor = .yellow
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
