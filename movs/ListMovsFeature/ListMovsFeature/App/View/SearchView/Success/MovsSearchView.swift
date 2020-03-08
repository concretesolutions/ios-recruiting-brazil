//
//  MovsSearchView.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 07/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit

class MovsSearchView: UIView {
    
    private let cellReuse = "Cell"
    var model = 0

    init(model: Int) {
        self.model = model
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var gridView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 8, right: 10)
        
        let cellInLine: CGFloat = 3
        let width = self.bounds.width / ( cellInLine + 1.0 )
        let height = width * 1.5
        
        layout.itemSize = CGSize(width: width, height: height)

        let collection = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collection.register(ItemMovsCollectionViewCell.self, forCellWithReuseIdentifier: cellReuse)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
}

//MARK: -Lifecycle-
extension MovsSearchView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(self.gridView)
        NSLayoutConstraint.activate([
            self.gridView.topAnchor.constraint(equalTo: self.topAnchor),
            self.gridView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.gridView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.gridView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        self.gridView.reloadData()
    }
}



//MARK: -Collection View Delegate -
extension MovsSearchView: UICollectionViewDelegateFlowLayout {
    
}

//MARK: -Collection View DataSource -
extension MovsSearchView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model
    }

    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let successCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellReuse, for: indexPath) as! ItemMovsCollectionViewCell
        successCell.model = indexPath.item
        return successCell
    }
    
}
