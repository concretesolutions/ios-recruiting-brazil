//
//  FirstViewController.swift
//  movs
//
//  Created by Lorien on 15/04/19.
//  Copyright © 2019 Lorien. All rights reserved.
//

import UIKit
import Rswift
import RxSwift

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [Movie] = []
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        getMovies()
    }
    
    fileprivate func getMovies() {
        AlamoRemoteSource()
            .getTopMovies()
            .asObservable()
            .subscribe(onNext: { response in
                self.movies = response.results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
            .disposed(by: disposeBag)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionCell
        cell.setup(with: movies[indexPath.row])
        return cell
    }

}

