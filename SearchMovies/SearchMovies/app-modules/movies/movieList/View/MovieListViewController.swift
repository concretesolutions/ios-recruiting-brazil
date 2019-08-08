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
        self.showActivityIndicator()
        self.presenter?.loadMovies()
    }
    
}

extension MovieListViewController : PresenterToMovieListViewProtocol {
    func returnMoviesError(message: String) {
        self.hideActivityIndicator()
        DispatchQueue.main.async {
           
            self.showPainelView(painelView: self.display, contentView: self.viewContent, description: "Um erro ocorreu, tente novamente mais tarde", typeReturn: .error)
        }
    }
    
    func returnMovies(movies: [MovieListData]) {
        self.hideActivityIndicator()
        self.movies = movies
        
 
        DispatchQueue.main.async {
            self.hidePainelView(painelView: self.display, contentView: self.viewContent)
            
            if (self.movies?.count)! > 0 {
                self.collectionView.delegate = self
                self.collectionView.dataSource = self
                self.collectionView.reloadData()
            }
            else {
                self.display.fill(description: "Sua busca não resultou nenhum resultado", typeReturn: .success)
                
                 self.showPainelView(painelView: self.display, contentView: self.viewContent, description: "Sua busca não resultou nenhum resultado", typeReturn: .success)
                
                
            }
        }
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
        
        cell.fill(title: movie.name, urlPhotoImage: "\(Constants.imdbBaseUrlImage)\(movie.imageUrl)")
        
        return cell
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
