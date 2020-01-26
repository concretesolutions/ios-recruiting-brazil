//
//  MoviesViewController.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 22/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class ListViewController: UIViewController{
    //MARK: - Variables
    var safeArea:UILayoutGuide!
    
    
    lazy var collectionView:UICollectionView = {
        
        //gridView
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = CGFloat(0)
        flowLayout.minimumInteritemSpacing = CGFloat(0)
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(tite), for: .allEvents)
        collectionView.refreshControl = refresh
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        //delegates
        collectionView.dataSource = self
        collectionView.delegate = self
        //cell setup
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        return collectionView
        
    }()
    //MARK: -Init methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(hex: dao.concreteDarkGray)
        safeArea = view.layoutMarginsGuide
        setContraints()
        getMovie(page:1)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            for cell in self.collectionView.visibleCells{
                let movieCell = cell as! MovieCollectionViewCell
                movieCell.refreshFavorite()
            }
        }
    }

    private func setContraints(){
        
        collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo:safeArea.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    //MARK: - Complimentary Methods
    
    @objc func tite(){
        debugPrint("teite")
        collectionView.refreshControl?.endRefreshing()
    }
    
    private func getMovie(page:Int){
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=0c909c364c0bc846b72d0fe49ab71b83&language=en-US&page=\(page)"
           let anonymousFunc = {(fetchedData:MovieSearch) in
               DispatchQueue.main.async {
                for movie in fetchedData.results{
                    movie.isFavorite = false
                    dao.searchResults.append(movie)
                }
                   self.collectionView.reloadData()
               }
           }
        api.movieSearch(urlStr: url, onCompletion: anonymousFunc)
           
       }
    
   
    

}

//MARK:- Extensions and Delegates
extension ListViewController:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dao.searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        let movie = dao.searchResults[indexPath.row]
//        movie.listIndexPath = indexPath
        cell.setUp(movie:movie)
        cell.refreshFavorite()
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == dao.searchResults.count - 1 {
            let page = dao.page + 1
            getMovie(page: page)
           }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width/2
        let height = self.view.frame.height/2
        let size:CGSize = CGSize(width: width, height: height)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = dao.searchResults[indexPath.row]
        let movieVc = MovieViewController()
        movieVc.setMovie(movie: movie)
//        imovieVc.cellIndexPath = indexPath
        movieVc.delegate = self
        dao.searchResults[indexPath.row] = movie
        self.present(movieVc, animated: true) {
        }
      
    }
    
    
    
}
extension ListViewController:CellUpdate{
    func updateList() {
        self.collectionView.reloadData()
    }
    
    func refreshFavorite(indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at:indexPath) as? MovieCollectionViewCell{
            cell.refreshFavorite()
        }else {return}
        
        
    }
    
}


