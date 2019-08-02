//
//  MoviesTabViewController.swift
//  Concrete Movies
//
//  Created by Henrique Barbosa on 31/07/19.
//  Copyright © 2019 Henrique Barbosa. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import SwiftSpinner

class MoviesTabViewController: ViewController {
    @IBOutlet weak var movieTabBarItem: UITabBarItem!
    @IBOutlet weak var moviesTabCollectionView: UICollectionView!
    @IBOutlet var moviesTabView: UIView!
    
    var movieDict: [String:Movie] = ["test" : Movie()]
    var indexes: [Int] = []

    override func viewWillAppear(_ animated: Bool) {
        moviesTabCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        collectionViewInitialSetup()
        collectionViewSetLayout()
        makeMoviesRequest()
    }
}

//Handles CollectionView
extension MoviesTabViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionViewInitialSetup() {
        SwiftSpinner.show("Just a minute...🍿")
        moviesTabCollectionView.delegate = self
        moviesTabCollectionView.dataSource = self
    }
    
    func collectionViewSetLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10.0
        layout.itemSize = CGSize(width: 200, height: 200)
        moviesTabCollectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(UINib(nibName: "MoviesTabCollection", bundle: Bundle(for: MoviesTabCollection.self)), forCellWithReuseIdentifier: "MoviesTabCollection")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesTabCollection", for: indexPath) as! MoviesTabCollection
        
        let key = String(indexPath.item)
        if((self.movieDict[key]) != nil) {
            cell.movieTitle.text = self.movieDict[key]?.name
            cell.movieImage.image = UIImage(data: self.movieDict[key]!.image!)
            cell.id = self.movieDict[key]!.id
            if(self.movieDict[key]!.favorite) {
                cell.favoriteButton.isSelected = true
                DispatchQueue.main.async {
                    cell.favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .selected)
                    cell.favoriteButton.layoutIfNeeded()
                }
            } else {
                cell.favoriteButton.isSelected = false
            }
        }
        
        cell.viewCellDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            collectionView.register(UINib(nibName: "MoviesTabHeader", bundle: Bundle(for: MoviesTabHeader.self)), forSupplementaryViewOfKind: kind, withReuseIdentifier: "MoviesTabHeader")
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MoviesTabHeader", for: indexPath)
            return header
        } else {
            assert(false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        performSegue(withIdentifier: "MovieDetails", sender: self)
    }
}

extension MoviesTabViewController: ImageDelegate {
    func makeMoviesRequest() {
        let request = MoviesGridRequest()
        request.imageDelegate = self
        request.moviesRequest()
    }
    
    func GetMovieImage(_ index: Int, _ movieID: Int) {
        getData(index, movieID)
    }
}

extension MoviesTabViewController {
    func getData(_ index: Int, _ movieID: Int) {
        indexes.append(index)
        let images = queryDatabase()
        images.forEach { (movie) in
            if(movie.id == movieID) {
                self.movieDict[String(index)] = movie
            }
        }
        let indexPath = IndexPath(item: index, section: 0)
        self.moviesTabCollectionView.reloadItems(at: [indexPath])
        if index > 15 {
            SwiftSpinner.hide()
        }
    }
    
    func queryDatabase() -> [Movie] {
        var movies: [Movie] = []
        do {
            let realm = try Realm()
            let result = realm.objects(Movie.self)
            result.forEach { (movie) in
                movies.append(movie)
            }
            return movies
        } catch {
            print("realm error")
            return [Movie()]
        }
    }
}

extension MoviesTabViewController: CollectionViewCellDelegate {
    
    func reloadView() {
        let moviesResult = self.queryDatabase()
        for(index, movie) in moviesResult.enumerated() {
            self.movieDict[String(indexes[index])] = movie
            let indexPath = IndexPath(item: index, section: 0)
            self.moviesTabCollectionView.reloadItems(at: [indexPath])
        }
    }
}
