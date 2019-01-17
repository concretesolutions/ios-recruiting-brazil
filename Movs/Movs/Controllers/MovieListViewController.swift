//
//  MovieListViewController.swift
//  Movs
//
//  Created by vinicius emanuel on 16/01/19.
//  Copyright © 2019 vinicius emanuel. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var moviesCollection: UICollectionView!
    private let cellID = "movieCollectionCellID"
    private let segueID = "listOfMoviesToMovieDetail"
    private var movieList: [MovieModel] = []
    private var selecteMovie: MovieModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moviesCollection.delegate = self
        self.moviesCollection.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        TMDBHelper.shared.getListOfMovies { [unowned self] (error, movies) in
            if let movies = movies{
                self.movieList = movies
                self.moviesCollection.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MovieDetailViewController
        vc.movie = self.selecteMovie
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! MovieCollectionViewCell
        
        let movie = self.movieList[indexPath.row]
        cell.movieName.text = movie.title
        cell .movieFavoImage.image = movie.favority ? #imageLiteral(resourceName: "favorite_full_icon") : #imageLiteral(resourceName: "favorite_gray_icon")
        let paceholder = #imageLiteral(resourceName: "placeholder")
        if let url = URL(string: movie.posterURl ?? ""){
            cell.movieImage.kf.setImage(with: url, placeholder: paceholder)
        }else{
            cell.movieImage.image = paceholder
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selecteMovie = self.movieList[indexPath.row]
        self.performSegue(withIdentifier: self.segueID, sender: self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
}
