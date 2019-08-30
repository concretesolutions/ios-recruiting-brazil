//
//  ViewController.swift
//  Concrete Movies
//
//  Created by Lucas Daniel on 24/08/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesCollectionView: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
}

class MoviesViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var moviesBase: MoviesBase?
    var moviesService = MoviesService()
    
    var stack = CoreDataStack.shared
    
    let handleMovie = HandleMovie()
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.moviesCollectionView.delegate   = self
        self.moviesCollectionView.dataSource = self
        
        getMovies()
        
        
    }

    func getMovies() {
        moviesService.getMovies { result in
            if result != nil {
                self.moviesBase = result
                self.moviesCollectionView.reloadData()
            } else {
                print("erro")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Screen.screenWidth*43/100, height: Screen.screenHeight*35/100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if moviesBase?.results != nil {
            return (moviesBase?.results!.count)!
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MoviesCollectionView
        
        cell.movieName.text = self.moviesBase?.results?[indexPath.item].title!
        //https://api.themoviedb.org/a4BfxRK8dBgbQqbRxPs8kmLd8LG.jpg
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + (self.moviesBase?.results?[indexPath.item].backdrop_path)!)
        cell.movieImage.kf.setImage(with: url)
        
        cell.favoriteButton.tag = indexPath.item
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(self.moviesBase?.results?[indexPath.row].title)
        
        let newViewController = storyboard?.instantiateViewController(withIdentifier: "MoviesDetailViewController") as! MoviesDetailViewController
        newViewController.movieID = (self.moviesBase?.results?[indexPath.row].id!)!
        present(newViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func favorite(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    
}

