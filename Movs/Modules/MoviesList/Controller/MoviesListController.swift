//
//  MoviesListController.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import UIKit

private let reuseIdentifier = "Cell"

class MoviesListController: UICollectionViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupSearchBar()
        
        MoviesListService().getMoviesList { [weak self] result in
            switch result {
            case .success(let movies):
                print(movies)
                
            case .failure(let message):
                print(message.localizedDescription)
            }
        }
    }
    
    private func setupCollectionView() {
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.backgroundColor = .white
    }
    
    private func setupSearchBar() {
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search a movie"

        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension MoviesListController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        cell.backgroundColor = .systemBlue
    
        return cell
    }
}
