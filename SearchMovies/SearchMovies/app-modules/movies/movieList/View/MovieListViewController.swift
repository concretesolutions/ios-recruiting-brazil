//
//  MovieListViewController.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
import UIKit

class MovieListViewController: BaseViewController {
    //MARK: Properties
    var presenter:ViewToMovieListPresenterProtocol?
    var cellIdentifier:String = "cellItem"
    private var movies:[MovieListData]!
    private var filteredData:[MovieListData]!
    private var isFiltered:Bool = false
    private var page:Int = 1
    private var totalItens:Int = 0
    private var isFavoriteMovie:Bool!
    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var display: DisplayInformationView!
    
    //MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieListRouter.setModule(self)
        self.movies = [MovieListData]()
        self.filteredData = [MovieListData]()
        self.searchBar.styleDefault()
        self.navigationController?.navigationBar.styleDefault()
        self.collectionView.register(UINib(nibName: "MovieListCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: cellIdentifier)
        self.hidePainelView(painelView: self.display, contentView: self.viewContent)
        self.searchBar.delegate = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showActivityIndicator()
        self.presenter?.loadGenrers()
        self.presenter?.loadFavorites()
        self.presenter?.loadMovies(page: page)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetailsSegue" {
            let navigation:UINavigationController = (segue.destination as! UINavigationController)
            let viewCtr:MovieDetailsViewController = (navigation.viewControllers[0] as! MovieDetailsViewController)
            
            if sender is MovieListData {
                viewCtr.movieId = (sender as! MovieListData).id
                viewCtr.genrerIds = (sender as! MovieListData).genreIds
                viewCtr.isFavoriteMovie = (sender as! MovieListData).isFavorite
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            if self.movies.count < self.totalItens {
                
                DispatchQueue.main.async {
                    self.page = self.page + 1
                    self.showActivityIndicator()
                    self.collectionView.setContentOffset(CGPoint.zero, animated: false)
                    self.presenter?.loadMovies(page: self.page)
                }
            }
        }
    }
    
}

extension MovieListViewController : PresenterToMovieListViewProtocol {
    func returnActionInFavoriteMovie(isFavorite: Bool, movieId: Int) {
        
    }
    
    func returnMoviesError(message: String) {
        self.hideActivityIndicator()
        DispatchQueue.main.async {
           
            self.showPainelView(painelView: self.display, contentView: self.viewContent, description: "Um erro ocorreu, tente novamente mais tarde", typeReturn: .error)
        }
    }
    
    func returnMovies(movies: [MovieListData], moviesTotal: Int) {
        
        self.totalItens = moviesTotal
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.hideActivityIndicator()
        }

        for item in movies {
                self.movies.append(item)
            }

       DispatchQueue.main.async {
        
            self.hidePainelView(painelView: self.display, contentView: self.viewContent)
            
            if (self.movies?.count)! > 0 {
                self.collectionView.delegate = self
                self.collectionView.dataSource = self
                self.collectionView.reloadData()
                
            }
            else {
                 self.showPainelView(painelView: self.display, contentView: self.viewContent, description: "Sua busca não resultou nenhum resultado", typeReturn: .success)
            }
        }
    }
    
    func returnLoadGenrers(genres: [GenreData]) {
        SingletonProperties.shared.genres = genres
    }
    
    func returnLoadGenrersError(message: String) {
        self.showPainelView(painelView: self.display, contentView: self.viewContent, description: message, typeReturn: .error)
    }
    
    func returnExistsInFavorites(isFavorite: Bool) {
        self.isFavoriteMovie = isFavorite
    }
}

extension MovieListViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.isFiltered ? self.filteredData.count : self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MovieListCollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieListCollectionViewCell
        let movie:MovieListData = self.isFiltered ? self.filteredData[indexPath.row] : self.movies[indexPath.row]
        cell.tag = movie.id
        self.presenter?.existsInFavorites(movieId: movie.id)
        
        cell.fill(title: movie.name, urlPhotoImage: "\(Constants.imdbBaseUrlImage)\(movie.imageUrl)", isFavoriteMovie: self.isFavoriteMovie)
        self.movies[indexPath.row].isFavorite = self.isFavoriteMovie
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie:MovieListData = self.isFiltered ? self.filteredData[indexPath.row] : self.movies[indexPath.row]
        self.presenter?.route?.pushToScreen(self, segue: "movieDetailsSegue", param: movie as AnyObject)
    }
}

extension MovieListViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
              if searchText.count == 0 {
       
            self.isFiltered = false
        }
        else {
            self.isFiltered = true
            self.filteredData = [MovieListData]()
            for result in self.movies {
                let nameRange:Range? = result.name.uppercased().range(of: searchText.uppercased())
                if  nameRange != nil{
                    self.filteredData.append(result)
                }
            }
        }
        self.hidePainelView(painelView: self.display, contentView: self.viewContent)
       
        
        self.collectionView.reloadData()
        if self.filteredData.count == 0 && self.isFiltered {
            DispatchQueue.main.async {
                 self.showPainelView(painelView: self.display, contentView: self.viewContent, description: "Sua busca por \(searchText) não resultou nenhum resultado", typeReturn: .success)
            }
        }
    }
}
