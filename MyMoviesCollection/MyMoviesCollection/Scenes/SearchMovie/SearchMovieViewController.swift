//
//  SearchMovieViewController.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 16/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

class SearchMovieViewController: UICollectionViewController, Alerts, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties

    public var searchString = ""
    private let reuseIdentifier = "movcell"
    private var viewModel: SearchMovieViewModel?
    private let itemsPerRow: CGFloat = 2
    private let numOfSects = 2
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 5.0, right: 10.0)
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    
    lazy var noResultsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = #imageLiteral(resourceName: "search_icon")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 26.0)
        label.textColor = ColorSystem.cBlueDark
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel = SearchMovieViewModel(delegate: self)
        viewModel?.fetchSearchMovies(text: searchString)
    }
    
    deinit {
        guard viewModel != nil else {
            return
        }
        viewModel = nil
    }
    
    // MARK: - Class Functions

    private func setUpNoResultsView() {
        view.addSubview(noResultsView)
        noResultsView.addSubview(imageView)
        noResultsView.addSubview(label)
        
        noResultsView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        noResultsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        noResultsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        noResultsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        imageView.bottomAnchor.constraint(equalTo: noResultsView.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: noResultsView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: noResultsView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: (view.frame.height / 4)).isActive = true
        
        label.topAnchor.constraint(equalTo: noResultsView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: noResultsView.leadingAnchor, constant: 45).isActive = true
        label.trailingAnchor.constraint(equalTo: noResultsView.trailingAnchor, constant: -45).isActive = true
        label.heightAnchor.constraint(equalToConstant: (view.frame.height / 4)).isActive = true
        
        label.text = "Sua busca por \u{22}\(searchString)\u{22} não resultou em nenhum resultado."
        
    }
    
    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let numOfMovs = viewModel?.currentCount else { return 0 }
        if (numOfMovs > 0) {
            if (numOfMovs % 2 == 0) {
                return (numOfMovs / 2)
            } else{
                return ((numOfMovs + 1) / 2)
            }
        }else {
            return 1
        }
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModelCount = viewModel?.currentCount else { return 0 }
        if viewModelCount > 0 {
            return 2
        }else{
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MoviesCollectionViewCell
        guard let collectionViewModel = viewModel else {
            cell.setCell(with: .none)
            return cell
        }
        if collectionViewModel.currentCount > 0 {
            var cellIndex: Int = 0
            if (indexPath.row == 0) {
                cellIndex = (indexPath.section * 2)
            } else{
                cellIndex = ((indexPath.section * 2) + 1)
            }
            cell.setCell(with: collectionViewModel.movie(at: cellIndex))
        } else {
            cell.setCell(with: .none)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: (widthPerItem * 1.5))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

}

// MARK: - MoviesViewModelDelegate

extension SearchMovieViewController: SearchMovieViewModelDelegate {
    func onFetchCompleted() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
        if viewModel?.currentCount == 0 {
            setUpNoResultsView()
        }
    }
    
    func onFetchFailed(with reason: String) {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: "Alerta" , message: reason, actions: [action])
    }
}
