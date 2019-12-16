//
//  TrendingMoviesView.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit
enum ErrorType {
    case generic
    case emptySearch
}
class TrendingMoviesView: UIView {
    lazy var errorRequestView = ErrorRequestView()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
    init() {
        super.init(frame: .zero)
        collectionView.register(MovieCollectionViewCell.self)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
    
    func reloadCollectionData() {
        collectionView.reloadData()
    }
    
    func invalidateCollectionLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func addErrorRequestView(imageName: String, message: String, isGenericError: Bool = true) {
        errorRequestView.imageView.image = UIImage(named: imageName)
        errorRequestView.label.text = message
        addSubview(errorRequestView)
        errorRequestView.anchor.attatch(to: safeAreaLayoutGuide)
        
        if isGenericError {
            errorRequestView.setupTryAgainButton()
        }
    }
    
    func removeErrorRequestView() {
        errorRequestView.removeFromSuperview()
    }
}

extension TrendingMoviesView: ViewCode {
    func buildViewHierarchy() {
        addSubview(collectionView)
    }
    
    func buildConstraints() {
        collectionView.anchor
            .attatch(to: safeAreaLayoutGuide, paddings: [.top(16), .left(16), .right(16), .bottom(16)])
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .white
        collectionView.backgroundColor = .white
    }
}
