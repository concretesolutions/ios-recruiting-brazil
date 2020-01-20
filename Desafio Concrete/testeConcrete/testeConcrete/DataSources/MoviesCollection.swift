//
//  MoviesCollection.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 12/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import UIKit

class MoviesCollectionDataSource:NSObject, UICollectionViewDataSource {
    var listMovie:[CollectionCellMovie] = [];
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
            MovieService.getMoviePoster(urlPoster: (movie.movie?.poster_path!)!){
                    response in
                    DispatchQueue.main.async {
                        
                        movie.image = response.success!
                        if(self.listMovie.last?.image   != nil){
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
                self.listMovie = []
                for item in popularList{
                    self.listMovie.append(CollectionCellMovie(movie: item, image: nil))
                }

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
            cell.imageView.image = listMovie[indexPath.row].image
        if(Armazenamento.estaFavoritado(id: listMovie[indexPath.row].movie!.id!)){
            cell.favoriteSign.isHidden = false
        } else{
            cell.favoriteSign.isHidden = true
        }
            // Configure the cell
            return cell
    }
}

