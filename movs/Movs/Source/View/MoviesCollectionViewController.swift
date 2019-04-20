//
//  FirstViewController.swift
//  movs
//
//  Created by Lorien on 15/04/19.
//  Copyright © 2019 Lorien. All rights reserved.
//

import UIKit

class MoviesCollectionViewController: UIViewController, MoviesViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: MoviesPresenter!
    var isSearching = false
    var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        presenter = MoviesPresenter(vc: self)
        presenter.getFavorites()
        presenter.getMovies()
        
        addSearchBar()
        addErrorLabel()
    }
    
    private func addSearchBar() {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.barStyle = .blackOpaque
        navigationItem.titleView = searchBar
    }
    
    private func addErrorLabel() {
        errorLabel = UILabel(frame: view.frame)
        view.addSubview(errorLabel)
        errorLabel.isHidden = true
        errorLabel.textColor = .red
        errorLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
    }
    
    func updateLayout() {
        collectionView.reloadData()
        guard let errorLabel = errorLabel else { return }
        errorLabel.isHidden = true
    }
    
    func showErrorLayout() {
        showErrorLayout(searchText: nil)
    }
    
    func showErrorLayout(searchText: String?) {
        errorLabel.isHidden = false
        guard let text = searchText else {
            errorLabel.text = """
            Um erro ocorreu. Por
            favor, tente novamente.
            """
            return
        }
        errorLabel.text = """
        Sua busca por "\(text)" não
        obteve nenhum
        resultado.
        """
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? MovieDetailsViewController,
            let cell = sender as? UICollectionViewCell
            else { return }
        let index = collectionView.indexPath(for: cell)?.row ?? 0
        destination.movie = presenter.movies[index]
    }

}

extension MoviesCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionCell
        cell.setup(with: presenter.movies[indexPath.row])
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.isEmpty else {
            isSearching = true
            presenter.movies = presenter.movies.filter{ $0.title.contains(searchText) }
            updateLayout()
            if presenter.movies.isEmpty {
                showErrorLayout(searchText: searchText)
            }
            return
        }
        isSearching = false
        presenter.movies = DataModel.sharedInstance.movies
        updateLayout()
    }
    
}

extension MoviesCollectionViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !presenter.isRequesting, !isSearching else { return }
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            presenter.getNewPage()
        }
    }
    
}
