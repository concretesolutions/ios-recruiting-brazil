//
//  FilmsDataSource.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 16/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilmsDataSource: NSObject, UICollectionViewDataSource {
    
    var films: [ResponseFilm] = [ResponseFilm]() {
        didSet {
            DispatchQueue.main.async {
                self.collection.reloadData()
            }
        }
    }
    
    var collection: UICollectionView!
    
    var lastRequest: Response!
    
    init(withCollection collection: UICollectionView){
        super.init()
        self.getNewMovies()
        collection.dataSource = self
        self.collection = collection
    }
    
    func getNewMovies(){
        NetworkManager.shared.fetchMovies { (result) in
            switch result{
            case .success(let filmsResponse):
                NetworkManager.shared.page+=1
                self.lastRequest = filmsResponse
                guard let films = filmsResponse.results else {
                    print("Error to cast films from response in: \(FilmsDataSource.self)")
                    return
                }
                self.films = films
                
            case .failure(let error):
                print("Error \(error.localizedDescription) in: \(FilmsDataSource.self)")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(film: films[indexPath.row])
        return cell
    }
    

}
