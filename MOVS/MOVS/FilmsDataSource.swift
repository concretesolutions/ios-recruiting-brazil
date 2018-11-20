//
//  FilmsDataSource.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 16/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilmsDataSource: NSObject, UICollectionViewDataSource {
    
    var films: [ResponseFilm] = [ResponseFilm]()
    
    var collection: UICollectionView!
    
    var lastRequest: Response!
    
    init(withCollection collection: UICollectionView){
        super.init()
        collection.dataSource = self
        self.collection = collection
    }
    
    func getNewMovies(){
        NetworkManager.shared.fetchMovies { (result) in
            switch result{
            case .success(let filmsResponse):
                guard let films = filmsResponse.results else {
                    print("Error to cast films from response in: \(FilmsDataSource.self)")
                    return
                }
                DispatchQueue.main.async {
                    self.collection.performBatchUpdates({
                        var indexPaths: [IndexPath] = [IndexPath]()
                        for i in self.films.count...self.films.count+films.count-1{
                            indexPaths.append(IndexPath(row: i, section: 0))
                        }
                        self.films.append(contentsOf: films)
                        self.collection.insertItems(at: indexPaths)
                    }, completion: nil)
                }
            case .failure(let error):
                print("Error \(error.localizedDescription) in: \(FilmsDataSource.self)")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(film: films[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell: EndCollectionViewCell = collectionView.dequeueReusableSupplementaryViewOfKind(ofKind: UICollectionView.elementKindSectionFooter, for: indexPath)
        cell.outletActivityIndicator.startAnimating()
        NetworkManager.shared.page+=1
        getNewMovies()
        cell.outletActivityIndicator.stopAnimating()
        return cell
    }
    
}
