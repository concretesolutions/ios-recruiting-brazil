//
//  PopularMoviesListView.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 14/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

class PopularMoviesListView: UIView {

    enum State {
        case loading, ready, error, fetchingContent
    }

    var viewState: State {
        didSet {
            collectionView.isHidden = true
            errorLabel.isHidden = true
            loadingActivityIndicator.isHidden = true
            loadingActivityIndicator.stopAnimating()

            switch viewState {
            case .loading:
                loadingActivityIndicator.isHidden = false
                loadingActivityIndicator.startAnimating()
            case .ready, .fetchingContent:
                collectionView.isHidden = false
            case .error:
                errorLabel.isHidden = false
            }
        }
    }

    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white

        return collectionView
    }()

    let loadingActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true

        return activityIndicator
    }()

    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = "Um erro ocorreu. Por favor, tente novamente."

        return label
    }()

    override init(frame: CGRect = .zero) {
        self.viewState = .ready
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(errorLabel)
        addSubview(loadingActivityIndicator)
        addSubview(collectionView)

        buildContraints()
        aditionalConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildContraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            loadingActivityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingActivityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }

    private func aditionalConfiguration() {
        collectionView.registerCell(PopularMovieCollectionViewCell.self)
    }
}
