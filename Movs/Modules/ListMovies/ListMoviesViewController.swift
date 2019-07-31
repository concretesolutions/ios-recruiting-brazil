//
//  ListMoviesViewController.swift
//  DesafioConcrete_BrunoChagas
//
//  Created by Bruno Chagas on 23/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

class ListMoviesViewController: UIViewController, ListMoviesView {
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: SearchBarView!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var errorMessage: UILabel!
    
    //MARK: - Contract Properties
    var presenter: ListMoviesPresentation!
    
    //MARK: - Properties
    var activityIndicator: UIActivityIndicatorView?
    var movies: [MovieEntity] = []
    var posters: [PosterEntity] = []
    
    //MARK: - View Start Functions
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        movieCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        self.adjustConstraints()
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        
        self.view.backgroundColor = ColorPalette.background.uiColor
        
        self.navigationController?.navigationBar.layer.zPosition = -1
        
        self.searchBar.searchBarText.delegate = self
        
        self.movieCollectionView.backgroundColor = .clear
        
        self.movieCollectionView.isHidden = true
        self.searchBar.isHidden = true
        self.errorImage.isHidden = true
        self.errorMessage.isHidden = true
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 10, y: self.view.frame.height / 2 - 40, width: 30, height: 30))
        activityIndicator?.color = .black
        activityIndicator?.startAnimating()
        self.view.addSubview(activityIndicator!)
        self.view.bringSubviewToFront(activityIndicator!)
    }
    
    //MARK: - Contract Functions
    func showNoContentScreen(image: UIImage?, message: String) {
        DispatchQueue.main.async {
            self.movieCollectionView.isHidden = true
            if !self.searchBar.searchBarText.isFirstResponder {
                self.searchBar.isHidden = true
            }
            
            self.errorMessage.isHidden = false
            self.errorMessage.text = message
            
            self.errorImage.isHidden = false
            self.errorImage.image = image
            
            if let act = self.activityIndicator {
                act.stopAnimating()
            }
        }
    }
    
    func showMoviesList(_ movies: [MovieEntity]) {
        self.movies = movies
        DispatchQueue.main.async {
            self.movieCollectionView.isHidden = false
            self.searchBar.isHidden = false
            self.errorMessage.isHidden = true
            self.errorImage.isHidden = true
            
            self.movieCollectionView.reloadData()
            if let act = self.activityIndicator {
                act.stopAnimating()
            }
        }
    }
    
    func updatePosters(_ posters: [PosterEntity]) {
        self.posters = posters
        DispatchQueue.main.async {
            self.movieCollectionView.reloadData()
        }
    }
    
    func adjustConstraints() {
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.errorMessage.translatesAutoresizingMaskIntoConstraints = false
        self.errorImage.translatesAutoresizingMaskIntoConstraints = false

        //MARK: Search bar constraints
        if let searchBar = self.searchBar {
            self.view.addConstraints([
                NSLayoutConstraint(item: searchBar, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: -2),
                NSLayoutConstraint(item: searchBar, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: searchBar, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: searchBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 50.0)
                
                ])
            
        }
        
        //MARK: Movie collectionview constraints
        if let movieCollectionView = self.movieCollectionView {
            self.view.addConstraints([
                NSLayoutConstraint(item: movieCollectionView, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 10),
                NSLayoutConstraint(item: movieCollectionView, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailingMargin, multiplier: 1.0, constant: -10),
                NSLayoutConstraint(item: movieCollectionView, attribute: .top, relatedBy: .equal, toItem: searchBar, attribute: .bottom, multiplier: 1.0, constant: 10),
                NSLayoutConstraint(item: movieCollectionView, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 10)
                ])
        }
        
        //MARK: Error image constraints
        if let errorImage = self.errorImage {
            self.view.addConstraints([
                NSLayoutConstraint(item: errorImage, attribute: .centerX, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: errorImage, attribute: .centerY, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerY, multiplier: 1.0, constant: -100),
                NSLayoutConstraint(item: errorImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 100),
                NSLayoutConstraint(item: errorImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 100)
                ])
        }
        
        //MARK: Error message constraints
        if let errorMessage = self.errorMessage {
            self.view.addConstraints([
                NSLayoutConstraint(item: errorMessage, attribute: .centerX, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: errorMessage, attribute: .top, relatedBy: .equal, toItem: errorImage, attribute: .bottom, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: errorMessage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 250),
                NSLayoutConstraint(item: errorMessage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 300)
                ])
        }
        
        self.view.updateConstraints()
    }
    
    //MARK: - Functions
    
    /**
     Check if it's ok to fetch more data.
     */
    func canFetchData() {
        if searchBar.searchBarText.text!.isEmpty {
            self.presenter.interactor.fetchMovies()
        }
    }
}

//MARK: - Collection View Extension Functions
extension ListMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return movies.count / 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        
        let movieForCell = self.movies[cellDistributionPosition(indexPath: indexPath)]
        let posterForCell = posters.first(where: { (image) -> Bool in
            image.movieId == movieForCell.id
        })
        
        let width = (collectionView.frame.size.width / 2) - 5
        let height = (collectionView.frame.size.height / 2.2) - 5
        cell.frame.size = CGSize(width: width, height: height)
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        cell.populate(with: movieForCell, poster: posterForCell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        presenter.didSelectMovie(movies[cellDistributionPosition(indexPath: indexPath)])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == (movies.count / 2) - 1 {
            self.canFetchData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width / 2) - 5
        let height = (collectionView.frame.size.height / 2.1) - 5
        return CGSize(width: width, height: height)
    }
    
    
    private func cellDistributionPosition(indexPath: IndexPath) -> Int {
        var position: Int = 0
        if indexPath.item == 0 {
            position = indexPath.section + indexPath.section
        }
        else if indexPath.item == 1 {
            position = indexPath.section + indexPath.section + 1
        }
        
        return position
    }
}

//MARK: - Search Bar Extension Functions
extension ListMoviesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text {
            presenter.didEnterSearch(text)
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}

