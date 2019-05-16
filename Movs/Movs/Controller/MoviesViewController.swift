//
//  MoviesViewController.swift
//  Movs
//
//  Created by Ygor Nascimento on 19/04/19.
//  Copyright © 2019 Ygor Nascimento. All rights reserved.
//

import UIKit
import CoreData

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Variables
    var moviesArray = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    let tmdbBasePosterImageURL = "https://image.tmdb.org/t/p/w342"
    var resultToPass: Movie!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        
        TMDBClient.loadMovies(onComplete: { (movies) in
            self.moviesArray = movies.results
            
            
        }) { (error) in
            print(error)
//            switch error {
//            case .invalidJSON
//                print("JSON inválido")
//            case .noData
//                print("Sem JSON")
//            case .url:
//                <#code#>
//            case .taskError(let error):
//                <#code#>
//            case .noResponse:
//                <#code#>
//            case .responseStatusCode(let code):
//                <#code#>
//            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MovieCollectionViewCell {
            
            let cellSpinner = UIActivityIndicatorView(style: .gray)
            cellSpinner.center = CGPoint(x: cell.contentView.frame.size.width / 2, y: cell.contentView.frame.size.height / 2)
            cellSpinner.startAnimating()
            
            let movie = moviesArray[indexPath.item]
            let imageUrl = URL(string:tmdbBasePosterImageURL+movie.poster_path)!
            let imageRequest = URLRequest(url: imageUrl)
            let imageCache = URLCache.shared
            
            if let data = imageCache.cachedResponse(for: imageRequest)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.cellLabel.text = movie.title
                    cell.cellImage.image = image
                    cellSpinner.stopAnimating()
                }
            } else {
                URLSession.shared.dataTask(with: imageRequest, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        imageCache.storeCachedResponse(cachedData, for: imageRequest)
                        
                        DispatchQueue.main.async {
                            cell.cellImage.image = image
                            cell.cellLabel.text = movie.title
                            cellSpinner.stopAnimating()
                        }
                    }
                }).resume()
            }
            cell.addSubview(cellSpinner)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        resultToPass = moviesArray[indexPath.item]
        performSegue(withIdentifier: "toMovieDetailsView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailsVC = segue.destination as? DetailsViewController {
            detailsVC.selectedMovie = resultToPass
        }
    }
}

extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
