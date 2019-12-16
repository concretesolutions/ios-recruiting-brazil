//
//  GenresDetailsTableViewCell.swift
//  Movs
//
//  Created by Gabriel D'Luca on 16/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class GenresDetailsTableViewCell: UITableViewCell {
    
    // MARK: - Interface Elements
    
    lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = UIColor(named: "detailsLabel")
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: "GenreCell")
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Initializers and Deinitializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return CGSize(width: targetSize.width, height: self.headingLabel.bounds.height + self.collectionView.bounds.height + 32.0)
    }
}

extension GenresDetailsTableViewCell: CodeView {
    func buildViewHierarchy() {
        self.contentView.addSubview(self.headingLabel)
        self.contentView.addSubview(self.collectionView)
    }
    
    func setupConstraints() {
        self.headingLabel.snp.makeConstraints({ make in
            make.top.leading.equalTo(self.contentView).offset(24.0)
        })
        
        self.collectionView.snp.makeConstraints({ make in
            make.top.equalTo(self.headingLabel.snp.bottom).offset(8.0)
            make.height.equalTo(32.0)
            make.leading.trailing.equalTo(self.contentView)
        })
    }
}
