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

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.hidesWhenStopped = true
        view.color = UIColor(named: "Yellow")
        return view
    }()

    private lazy var errorView: ExceptionView = {
        let view = ExceptionView(imageSystemName: "xmark.circle.fill", text: "An error occurred. Please try again later.")
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

    // MARK: - Activity Indicator handlers

    func startLoading() {
        self.activityIndicator.startAnimating()
    }

    func stopLoading() {
        self.activityIndicator.stopAnimating()
    }

    // MARK: - Error handlers

    func displayError() {
        self.collectionView.backgroundView = self.errorView
    }
}

extension PopularMoviesScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.collectionView)
        self.addSubview(self.activityIndicator)
    }

    func setupContraints() {
        self.collectionView.snp.makeConstraints { maker in
            maker.top.equalTo(self.safeAreaLayoutGuide)
            maker.bottom.equalTo(self.safeAreaLayoutGuide)
            maker.leading.equalTo(self.safeAreaLayoutGuide)
            maker.trailing.equalTo(self.safeAreaLayoutGuide)
        }

        self.activityIndicator.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
        }
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .systemBackground
    }
}
