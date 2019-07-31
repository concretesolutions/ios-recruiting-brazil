//
//  FavoriteMoviesViewController.swift
//  DesafioConcrete_BrunoChagas
//
//  Created by Bruno Chagas on 23/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import UIKit

class FavoriteMoviesViewController: UIViewController, FavoriteMoviesView {
    
    //MARK: - Outlets
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var filterScreenButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: SearchBarView!
    @IBOutlet weak var clearFilterButton: UIButton!
    @IBOutlet weak var favoriteMoviesTableView: UITableView!
    
    //MARK: - Contract Properties
    var presenter: FavoriteMoviesPresentation!
    var isFilterActive: Bool! {
        didSet {
            if isFilterActive {
                clearFilterButton.frame.size = CGSize(width: clearFilterButton.frame.width, height: 70)
                clearFilterButton.isHidden = false
            }
            else {
                presenter.filters = nil
                clearFilterButton.frame.size = CGSize(width: clearFilterButton.frame.width, height: 0)
                clearFilterButton.isHidden = true
            }
        }
    }
    
    //MARK: - Properties
    var favoriteMovies: [MovieEntity] = []
    var posters: [PosterEntity] = []
    
    //MARK: - View Start Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            presenter.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        adjustConstraints()
        self.navigationController?.navigationBar.layer.zPosition = -1
        self.view.backgroundColor = ColorPalette.background.uiColor
        
        searchBar.searchBarText.delegate = self
        
        clearFilterButton.frame.size = CGSize(width: clearFilterButton.frame.width, height: 0)
        clearFilterButton.backgroundColor = ColorPalette.darkBlue.uiColor
        clearFilterButton.isHidden = true
        
        self.errorImage.isHidden = true
        self.errorText.isHidden = true
        
        favoriteMoviesTableView.backgroundColor = ColorPalette.background.uiColor
    }
    
    //MARK: - Contract Functions
    func showNoContentScreen(image: UIImage?, message: String) {
        DispatchQueue.main.async {
            if !self.searchBar.searchBarText.isFirstResponder {
                self.searchBar.isHidden = true
            }
            self.favoriteMoviesTableView.isHidden = true
            
            self.errorImage.isHidden = false
            self.errorImage.image = image
            
            self.errorText.isHidden = false
            self.errorText.text = message
        }
    }
    
    func showFavoriteMoviesList(_ movies: [MovieEntity], posters: [PosterEntity]) {
        self.searchBar.isHidden = false
        self.favoriteMoviesTableView.isHidden = false
        self.errorImage.isHidden = true
        self.errorText.isHidden = true
        
        self.favoriteMovies = movies
        self.posters = posters
        favoriteMoviesTableView.reloadData()
    }
    
    func adjustConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        clearFilterButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteMoviesTableView.translatesAutoresizingMaskIntoConstraints = false
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        errorText.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Search bar constraints
        if let searchBar = self.searchBar {
            self.view.addConstraints([
                NSLayoutConstraint(item: searchBar, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: searchBar, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: searchBar, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: -2),
                NSLayoutConstraint(item: searchBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 50)
                ])
        }
        
        //MARK: Clear filter button constraints
        if let clearFilterButton = self.clearFilterButton {
            self.view.addConstraints([
                NSLayoutConstraint(item: clearFilterButton, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: clearFilterButton, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: clearFilterButton, attribute: .top, relatedBy: .equal, toItem: searchBar, attribute: .bottom, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: clearFilterButton, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .height, multiplier: 1.0, constant: 70)
                ])
        }
        
        //MARK: Favorite movies tableView constraints
        if let favoriteMoviesTableView = self.favoriteMoviesTableView {
            self.view.addConstraints([
                NSLayoutConstraint(item: favoriteMoviesTableView, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: favoriteMoviesTableView, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: favoriteMoviesTableView, attribute: .top, relatedBy: .equal, toItem: clearFilterButton, attribute: .bottom, multiplier: 1.0, constant: 5),
                NSLayoutConstraint(item: favoriteMoviesTableView, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0)
                ])
        }
        
        //MARK: Error image constraints
        if let errorImage = self.errorImage {
            self.view.addConstraints([
                NSLayoutConstraint(item: errorImage, attribute: .centerX, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: errorImage, attribute: .centerY, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerY, multiplier: 1.0, constant: -100),
                NSLayoutConstraint(item: errorImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 70),
                NSLayoutConstraint(item: errorImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 70)
                ])
        }
        
        //MARK: Error text constraints
        if let errorText = self.errorText {
            self.view.addConstraints([
                NSLayoutConstraint(item: errorText, attribute: .centerX, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: errorText, attribute: .top, relatedBy: .equal, toItem: errorImage, attribute: .bottom, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: errorText, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 250),
                NSLayoutConstraint(item: errorText, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 300)
                ])
        }
        
        self.view.updateConstraints()
    }
    
    //MARK: - Functions
    @IBAction func didSelectFilterButton(_ sender: UIBarButtonItem) {
        if favoriteMovies.count > 0 {
            presenter.didPressFilter()
        }
        else {
            let alert = UIAlertController(title: nil, message: "There are no movies to filter.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func didSelectClearFilter(_ sender: UIButton) {
        self.isFilterActive = false
        presenter.viewDidLoad()
    }
    
}

//MARK: - Table View Extension Functions
extension FavoriteMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteMovieCell", for: indexPath) as! FavoriteMovieTableViewCell
        
        tableView.rowHeight = 110.0
        
        let movie = self.favoriteMovies[indexPath.row]
        let poster = self.posters.first { (post) -> Bool in
            post.movieId == movie.id
        }
        cell.populate(with: movie, poster: poster)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.favoriteMovies[indexPath.row]
        let poster = self.posters.first { (post) -> Bool in
            post.movieId == movie.id
        }
        presenter.didSelectMovie(movie, poster: poster)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.didDeleteFavorite(movie: favoriteMovies[indexPath.row])
        }
    }
    
}

//MARK: - Search Bar Extension Functions
extension FavoriteMoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text {
            presenter.didEnterSearch(text)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
