//
//  MoviesView.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 18/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

class MoviesView: UIView, ViewCode {

    lazy var loadingView = LoadingView()

    lazy var emptyView = EmptyView()

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout:
        CustomCollectionViewFlowLayout(columns: 2, padding: 8, aspectRatio: 1.5)
    )
        .set(\.backgroundColor, to: .clear)

    required override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        setupSubviews()
        setupLayout()

        setLoadingLayout()
    }

    func setupSubviews() {
        addSubview(collectionView)
        addSubview(loadingView)
        addSubview(emptyView)
    }

    func setupLayout() {
        collectionView.fillToSuperview()
        loadingView.fillToSuperview()
        emptyView.fillToSuperview()
    }

    // MARK: View updates

    func setLoadingLayout() {
        loadingView.isHidden = false
        loadingView.start()

        emptyView.isHidden = true
        collectionView.isHidden = true
    }

    func setEmptyLayout() {
        loadingView.isHidden = true
        loadingView.stop()

        emptyView.isHidden = false
        collectionView.isHidden = true
    }

    func setShowLayout() {
        loadingView.isHidden = true
        loadingView.stop()

        emptyView.isHidden = true
        collectionView.isHidden = false
    }
}
