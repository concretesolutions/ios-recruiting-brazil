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
        case loading, ready, error
    }

    var viewState: State {
        didSet {
            switch viewState {
            case .loading:
                collectionView.isHidden = true
                errorLabel.isHidden = true
                loadingActivityIndicator.isHidden = false
                loadingActivityIndicator.startAnimating()
            case .ready:
                collectionView.isHidden = false
                errorLabel.isHidden = true
                loadingActivityIndicator.stopAnimating()
            case .error:
                errorLabel.isHidden = false
                collectionView.isHidden = true
                loadingActivityIndicator.stopAnimating()
            }
        }
    }

    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.registerCell(PopularMovieCollectionViewCell.self)
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
}
