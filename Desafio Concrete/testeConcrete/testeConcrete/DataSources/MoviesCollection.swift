//
//  MoviesCollection.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 12/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import UIKit

class MoviesCollectionDataSource:NSObject, UICollectionViewDataSource {
    var listMovie:[Movie] = [];
    var listPoster:[UIImage] = []
    override init(){
        super.init()
        loadListeners()
        loadMovies()
    }
    
    func loadListeners(){
        NotificationCenter.default.addObserver(self, selector: #selector(loadPosters), name: Notification.loadedPopularMovies, object: nil)
    }
    
    @objc func loadPosters(){
            for movie in self.listMovie{
                MovieService.getMoviePoster(urlPoster: movie.poster_path!){
                    response in
                    DispatchQueue.main.async {
                        self.listPoster.append(response.success!)
                        if(self.listPoster.count == self.listMovie.count){
                            NotificationCenter.default.post(name: Notification.finishedLoadedMovieAndPoster, object: nil)
                        }
                    }
                }
            }
    }
    
    func loadMovies(){
        DispatchQueue.main.async{
            PopularMoviesService.getPopularMovies(page: 1){
                response in
                guard let popularList = response.success else{return }
                self.listMovie = popularList
                NotificationCenter.default.post(name: Notification.loadedPopularMovies, object: nil)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
        cell.imageView.image = listPoster[indexPath.row]
            // Configure the cell
            return cell
    }
}

