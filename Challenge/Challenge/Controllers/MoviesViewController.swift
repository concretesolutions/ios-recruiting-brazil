//
//  MoviesViewController.swift
//  Challenge
//
//  Created by Sávio Berdine on 22/10/18.
//  Copyright © 2018 Sávio Berdine. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var movies: [Movie] = []
    var page = 1
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        self.collectionView.addSubview(self.refreshControl)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        handlePagination()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func handlePagination() {
        print("Handling pagination")
        Movie.getPopularMovies(pageToRequest: self.page, onSuccess: { (moviesResult) in
            self.movies.append(contentsOf: moviesResult)
            self.page += 1
            self.collectionView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("Handling refresh")
        self.page = 1
        handlePagination()
        self.collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentOffset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.height
        if maxOffset - currentOffset <= 40 {
            self.handlePagination()
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/2.0
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MoviesCollectionViewCell
        cell.label.text = self.movies[indexPath.row].name
        cell.imageView.kf.indicatorType = .activity
        cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280/\(String(describing: self.movies[indexPath.row].imagePath!))"))
        return cell
    }
    
    private func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: MoviesCollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.imageView.kf.cancelDownloadTask()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: false)
        self.performSegue(withIdentifier: "moviesToDetails", sender: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moviesToDetails" {
            
        }
    }
    

}
