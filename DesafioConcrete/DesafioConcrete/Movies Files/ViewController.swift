//
//  ViewController.swift
//  DesafioConcrete
//
//  Created by Luiz Otavio Processo on 30/11/19.
//  Copyright © 2019 Luiz Otavio Processo. All rights reserved.
//

import UIKit

protocol UpdateDataProtocol: class{
    func updateData(movies:MovieModel)
    func updateGenreTypes(genres:GenreTypes)
}

class ViewController: UIViewController{

    var movies:[Results] = []
    var moviesView:MoviesView?
    var moviesRequest:MoviesRequest?
    
    var getMoreMovies = false
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //get data from api
        moviesRequest = MoviesRequest(delegate: self)
        moviesRequest!.fetchFilmesFromAPI(page: page)
        moviesRequest?.fetchGenreTypes()
        
        //sync to retrieve data fo fill view
        DispatchQueue.main.async {
            self.moviesView = MoviesView(frame: self.view.frame)
            self.view = self.moviesView
            self.setCollection()
            
        }
    }

    func setCollection(){
        
        moviesView!.collectionView!.delegate = self
        moviesView!.collectionView!.dataSource = self
        moviesView!.collectionView?.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: "moviesCollectionViewCell")

    }

    // paging collection view
    func fetchMoreMovies(){
        getMoreMovies = true
        DispatchQueue.main.async {
            self.page += 1
            self.moviesRequest?.fetchFilmesFromAPI(page: self.page)
            self.getMoreMovies = false
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as? MoviesCollectionViewCell
        
        moviesRequest!.getMovieImg((movies[indexPath.row].poster_path)!, completionHandler: {img in
            cell!.image.image = img
        })
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let destination = DetailViewController(result: (movies[indexPath.row]))
        moviesRequest!.getMovieImg((movies[indexPath.row].poster_path)!, completionHandler: {img in
            destination.movieImg = img
        })
        navigationController?.pushViewController(destination, animated: true)
    }
    
}
    
extension ViewController{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let verticalScroll = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (verticalScroll > contentHeight - scrollView.frame.height){
            if(!getMoreMovies){
                fetchMoreMovies()
            }
        }
    }
}

extension ViewController:UpdateDataProtocol{
    //updates the genre types
    func updateGenreTypes(genres: GenreTypes) {
        Singleton.shared.genresArray = genres.genres
    }
    
    //update view with data from api
    func updateData(movies: MovieModel) {
        self.movies.append(contentsOf: movies.results)
        moviesView?.collectionView?.reloadData()
    }
}
