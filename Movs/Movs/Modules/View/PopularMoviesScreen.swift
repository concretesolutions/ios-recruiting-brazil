//
//  PopularMoviesScreen.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 06/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import SnapKit
import UIKit

final class PopularMoviesScreen: UIView {

    // MARK: - Delegate

    weak var delegate: PopularMoviesScreenDelegate? {
        didSet {
            self.collectionView.delegate = self.delegate
            self.collectionView.dataSource = self.delegate
        }
    }

    // MARK: - Subviews

    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.register(PopularMovieCell.self, forCellWithReuseIdentifier: PopularMovieCell.reusableIdentifier)
        view.delegate = self.delegate
        view.dataSource = self.delegate
        view.backgroundColor = .systemBackground
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        return view
    }()

    // MARK: - Initializers

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PopularMoviesScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.collectionView)
    }

    func setupContraints() {
        self.collectionView.snp.makeConstraints { maker in
            maker.top.equalTo(self.safeAreaLayoutGuide)
            maker.bottom.equalTo(self.safeAreaLayoutGuide)
            maker.leading.equalTo(self.safeAreaLayoutGuide)
            maker.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .systemBackground
    }
}
