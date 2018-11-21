//
//  FilmsDataSource.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 16/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class CollectionDataSource: NSObject, UICollectionViewDataSource {
    
    var films: [ResponseFilm] = [ResponseFilm]()
    
    var collection: UICollectionView!
    
    var totalPages: Int! = 1000000
    
    init(withCollection collection: UICollectionView){
        super.init()
        collection.dataSource = self
        self.collection = collection
    }
    
    func getNewMovies(withActivityIndicator activity: UIActivityIndicatorView){
        
        if totalPages >= NetworkManager.shared.page {
            activity.startAnimating()
            NetworkManager.shared.fetchMovies { (result) in
                switch result{
                case .success(let filmsResponse):
                    guard let films = filmsResponse.results else {
                        print("Error to cast films from response in: \(CollectionDataSource.self)")
                        return
                    }
                    if let totalPages = filmsResponse.total_pages{
                        self.totalPages = totalPages
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
                        activity.stopAnimating()
                    }
                case .failure(let error):
                    print("Error \(error.localizedDescription) in: \(CollectionDataSource.self)")
                }
            }
        }else{
            activity.alpha = 0
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
        NetworkManager.shared.page+=1
        getNewMovies(withActivityIndicator: cell.outletActivityIndicator)
        return cell
    }
    
}
