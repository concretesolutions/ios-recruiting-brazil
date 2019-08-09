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
        self.presenter?.loadMovies(page: page)
        
        
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.hideActivityIndicator()
        }

        for item in movies {
                self.movies.append(item)
            }

       DispatchQueue.main.async {
        
            self.hidePainelView(painelView: self.display, contentView: self.viewContent)
            
            if (self.movies?.count)! > 0 {
                self.totalItens = self.totalItens + self.movies.count
                self.collectionView.delegate = self
                self.collectionView.dataSource = self
                self.collectionView.reloadData()
                self.collectionView.setContentOffset(CGPoint.zero, animated: false)
            }
            else {
                self.display.fill(description: "Sua busca não resultou nenhum resultado", typeReturn: .success)
                
                 self.showPainelView(painelView: self.display, contentView: self.viewContent, description: "Sua busca não resultou nenhum resultado", typeReturn: .success)
                
                
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            if self.movies.count <= self.totalItens {
                
                DispatchQueue.main.async {
                    self.page = self.page + 1
                    self.showActivityIndicator()
                    self.presenter?.loadMovies(page: self.page)
                }
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
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.row == self.movies.count - 1  && self.movies.count < self.totalItens {
//            page = page + 1
//            self.showActivityIndicator()
//            self.presenter?.loadMovies(page: page)
//        }
//    }
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
