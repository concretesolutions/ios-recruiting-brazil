//
//  MoviesViewController.swift
//  Movs
//
//  Created by Ygor Nascimento on 19/04/19.
//  Copyright © 2019 Ygor Nascimento. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Variables
    var moviesArray = [Results]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    let tmdbBaseImageURL = "https://image.tmdb.org/t/p/w500"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Search Bar on Navigation Controller
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        
        //URLCache
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "disk")
        //URLCache.shared.cachedResponse(for: <#T##URLRequest#>)
        
        
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
            let movie = moviesArray[indexPath.item]
            
            let imageUrl = URL(string:tmdbBaseImageURL+movie.poster_path)!
            let data = try? Data(contentsOf: imageUrl)
            
            cell.cellLabel.text = movie.title
            cell.cellImage.image = UIImage(data: data!)
            
            
            return cell
        }
        return UICollectionViewCell()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = view.bounds.width
//        let cellDimension = (width / 2) - 15
//        
//        return CGSize(width: cellDimension, height: cellDimension)
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
