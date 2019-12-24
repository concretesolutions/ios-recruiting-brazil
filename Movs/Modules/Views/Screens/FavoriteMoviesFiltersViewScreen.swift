//
//  FavoriteMoviesFiltersViewScreen.swift
//  Movs
//
//  Created by Gabriel D'Luca on 19/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import SnapKit

final class FavoriteMoviesFiltersViewScreen: UIView {
    
    // MARK: - Interface Elements
    
    lazy var releaseYearHeading: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Release Year"
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        return label
    }()
    
    lazy var yearPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    lazy var genresHeading: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Genres"
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        return label
    }()
    
    lazy var genresCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: "GenreCell")
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var filterButton: ImportantActionButton = {
        let button = ImportantActionButton(frame: .zero)
        button.setTitle("Apply", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.backgroundColor = UIColor(named: "palettePurple")
        button.layer.cornerRadius = 16.0
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.tintColor = UIColor.white
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.backgroundColor = UIColor.systemRed
        return button
    }()
    
    // MARK: - Initializers and Deinitializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteMoviesFiltersViewScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.genresHeading)
        self.addSubview(self.resetButton)
        self.addSubview(self.genresCollection)
        self.addSubview(self.releaseYearHeading)
        self.addSubview(self.yearPicker)
        self.addSubview(self.filterButton)
    }
    
    func setupConstraints() {
        self.resetButton.snp.makeConstraints({ make in
            make.top.trailing.equalTo(self).inset(24.0)
            make.width.height.equalTo(32.0)
        })

        self.genresHeading.snp.makeConstraints({ make in
            make.top.equalTo(self.resetButton.snp.bottom).offset(32.0)
            make.leading.equalTo(self).inset(24.0)
        })
        
        self.genresCollection.snp.makeConstraints({ make in
            make.centerX.width.equalTo(self)
            make.top.equalTo(self.genresHeading.snp.bottom).offset(16.0)
            make.height.equalTo(32.0)
        })
        
        self.releaseYearHeading.snp.makeConstraints({ make in
            make.top.equalTo(self.genresCollection.snp.bottom).offset(32.0)
            make.leading.equalTo(self).inset(24.0)
        })
        
        self.yearPicker.snp.makeConstraints({ make in
            make.centerX.width.equalTo(self)
            make.top.equalTo(self.releaseYearHeading.snp.bottom).offset(16.0)
            make.height.equalTo(self.yearPicker.snp.width).multipliedBy(0.4)
        })
        
        self.filterButton.snp.makeConstraints({ make in
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.45)
            make.height.equalTo(self.filterButton.snp.width).multipliedBy(0.33)
            make.bottom.equalTo(self).inset(24.0)
        })
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .systemBackground
        self.resetButton.layer.cornerRadius = 16.0
        self.resetButton.layer.masksToBounds = true
    }
}
