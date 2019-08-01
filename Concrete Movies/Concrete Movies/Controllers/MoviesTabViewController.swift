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

class MoviesTabViewController: ViewController {
    @IBOutlet weak var movieTabBarItem: UITabBarItem!
    @IBOutlet weak var moviesTabCollectionView: UICollectionView!
    var images: [UIImage] = []
    var movieTitles: [String] = []
    
    override func viewDidLoad() {
        collectionViewInitialSetup()
        collectionViewSetLayout()
        makeMoviesRequest()
    }
}

//Handles CollectionView
extension MoviesTabViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionViewInitialSetup() {
        moviesTabCollectionView.delegate = self
        moviesTabCollectionView.dataSource = self
        moviesTabCollectionView.reloadData()
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(UINib(nibName: "MoviesTabCollection", bundle: Bundle(for: MoviesTabCollection.self)), forCellWithReuseIdentifier: "MoviesTabCollection")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesTabCollection", for: indexPath) as! MoviesTabCollection
        if(self.images.first != nil && self.movieTitles.first != nil) {
            cell.movieTitle.text = movieTitles[indexPath.item]
            cell.movieImage.image = images[indexPath.item]
        }
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
    
    func GetMovieImage() {
        getData()
        self.moviesTabCollectionView.reloadData()
    }
}

extension MoviesTabViewController {
    func getData() {
        let realm = try! Realm()
        let images = realm.objects(Movie.self)
        images.forEach { (movie) in
            guard let data = movie.image else { return }
            guard let image = UIImage(data: data) else { return }
            self.images.append(image)
            let text = movie.name
            self.movieTitles.append(text)
        }
    }
}
