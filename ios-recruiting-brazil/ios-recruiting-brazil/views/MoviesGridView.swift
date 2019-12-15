//
//  MoviesGridView.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
class MoviesGridView: UIView, ConfigView {
    let grid: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.registerCell(cellType: MoviesCollectionViewCell.self)
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createViewHierarchy() {
        self.addSubview(grid)
    }

    func addConstraints() {
        //grid constraints
        NSLayoutConstraint.activate([
            grid.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            grid.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            grid.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            grid.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    func setAdditionalConfiguration() {
        self.backgroundColor = .white
    }
}
