//
//  MoviesController.swift
//  ios_recruit_challenge
//
//  Created by Lucas de Brito on 09/10/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MoviesController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    var movieView = MoviesView()
    let cellId = "cellId"
    var loadingContent = false
    var actualPage = 1
    var lastPage = 10
    var movieTitleList:[String] = []
    var moviePosterUrlList:[String] = []
    var movieIdList:[String] = []
    var favoriteMovieIndexList:[Int] = []
    var favoriteMovieArray:[FavoriteMovie] = []
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        setup()
        print(dateFormatter(date: "2018-10-25"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUserData()
        movieView.collectionView.reloadData()
    }
    
    //MARK: - Setup view
    func setup(){
        movieView = MoviesView(frame: self.view.frame)
        movieView.collectionView.delegate = self
        movieView.collectionView.dataSource = self
        movieView.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        self.view.addSubview(movieView)
    }
    
    //MARK: - update user model
    func updateUserData(){
        if UserDefaultsManager.shared.isThereAnyFavoriteMovie{
            favoriteMovieArray = UserDefaultsManager.shared.favoriteMoviesArray
            favoriteMovieIndexList = UserDefaultsManager.shared.favoriteMoviesIndexArray
        }
    }
    
    // MARK: - CollectionView DataSource and Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieTitleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width/2) - 8, height: 180)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieCollectionViewCell
        cell.movieNameLabel.text = fitMovieTitleInoLabel(title: movieTitleList[indexPath.row])
        cell.imageView.loadImage(urlString: "https://image.tmdb.org/t/p/w200/" + moviePosterUrlList[indexPath.row])
        cell.isUserInteractionEnabled = true
        cell.favButton.tag = Int(movieIdList[indexPath.row])!
        cell.favButton.addTarget(self, action: #selector(editFavoriteList), for: .touchUpInside)
        cell.favButton.setImage(setBtnImage(index: Int(movieIdList[indexPath.row])!), for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = collectionView.cellForItem(at: indexPath) as! MovieCollectionViewCell
        collectionView.allowsSelection = false
        getJsonData(url: "https://api.themoviedb.org/3/movie/" + String(x.favButton.tag) + "?api_key=25655d622412630c8d690077b4a564f6&language=en-US") { (response) in
            print(response)
            let movieDetailViewController = MovieDetailController()
            let jsonResponse = JSON(response)
            movieDetailViewController.moviePosterUrl = jsonResponse["poster_path"].stringValue
            movieDetailViewController.movieName = jsonResponse["title"].stringValue
            movieDetailViewController.movieOverview = jsonResponse["overview"].stringValue
            movieDetailViewController.movieGenres = jsonResponse["genres"].arrayValue.map({$0["name"].stringValue})
            movieDetailViewController.movieRelaseDate = jsonResponse["release_date"].stringValue
            movieDetailViewController.movieIdList = self.movieIdList
            movieDetailViewController.favoriteMovieIndexList = self.favoriteMovieIndexList
            movieDetailViewController.movieGridIndex = indexPath.row
            movieDetailViewController.movieApiIndex = jsonResponse["id"].intValue
            self.navigationController?.pushViewController(movieDetailViewController, animated: true)
            collectionView.allowsSelection = true
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height{
            if !loadingContent{
                loadingContent = true
                getJsonData(url: "https://api.themoviedb.org/3/movie/popular?api_key=25655d622412630c8d690077b4a564f6&language=en-US&page=" + String(actualPage)) { response in
                    self.actualPage = self.actualPage + 1
                    let jsonResponse = JSON(response)
                    self.lastPage = jsonResponse["total_pages"].intValue
                    self.movieTitleList = self.movieTitleList + jsonResponse["results"].arrayValue.map({$0["title"].stringValue})
                    self.moviePosterUrlList = self.moviePosterUrlList + jsonResponse["results"].arrayValue.map({$0["poster_path"].stringValue})
                    self.movieIdList = self.movieIdList + jsonResponse["results"].arrayValue.map({$0["id"].stringValue})
                    self.movieView.collectionView.reloadData()
                    self.loadingContent = false
                }
            }
        }
        
    }
    
    // MARK: - Auxiliar functions
    @objc func editFavoriteList(sender: UIButton){
        sender.isEnabled = false
        movieView.collectionView.allowsSelection = false
        if favoriteMovieIndexList.contains(sender.tag){
            if let index = favoriteMovieIndexList.index(of: sender.tag){
                favoriteMovieIndexList.remove(at: index)
                favoriteMovieArray.remove(at: index)
                UserDefaultsManager.shared.favoriteMoviesArray = self.favoriteMovieArray
                UserDefaultsManager.shared.favoriteMoviesIndexArray = self.favoriteMovieIndexList
                movieView.collectionView.allowsSelection = true
                sender.isEnabled = true
                movieView.collectionView.reloadData()
            }
        }else{
            getJsonData(url: "https://api.themoviedb.org/3/movie/" + String(sender.tag) + "?api_key=25655d622412630c8d690077b4a564f6&language=en-US", completion: { (response) in
                print(response)
                let jsonResponse = JSON(response)
                let movieTitle = jsonResponse["title"].stringValue
                let moviePosterUrl = jsonResponse["poster_path"].stringValue
                let movieReleaseDate = jsonResponse["release_date"].stringValue
                let movieGenre = jsonResponse["genres"].arrayValue.map({$0["name"].stringValue})
                let favoritedMovie = FavoriteMovie(movieTitle: movieTitle, moviePosterUrl: moviePosterUrl, movieReleaseDate: movieReleaseDate, movieGenre: movieGenre)
                self.favoriteMovieArray.append(favoritedMovie)
                self.favoriteMovieIndexList.append(sender.tag)
                UserDefaultsManager.shared.isThereAnyFavoriteMovie = true
                UserDefaultsManager.shared.favoriteMoviesArray = self.favoriteMovieArray
                UserDefaultsManager.shared.favoriteMoviesIndexArray = self.favoriteMovieIndexList
                self.movieView.collectionView.allowsSelection = true
                sender.isEnabled = true
                self.movieView.collectionView.reloadData()
            })
            
        }
    }
    
    func setBtnImage(index:Int) -> UIImage{
        if favoriteMovieIndexList.contains(index){
            return UIImage(named: "fullHeart")!
        }else{
            return UIImage(named: "heart")!
        }
    }
    
    
    func getJsonData(url: String, completion:@escaping (Any) -> Void){
        Alamofire.request(url).responseJSON { (response) in
            guard response.result.isSuccess,
                let value = response.result.value else {
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    return
            }
            completion(value)
        }
    }
    
    func fitMovieTitleInoLabel(title: String) -> String{
        let nsString = title as NSString
        if nsString.length >= 10{
            return nsString.substring(with: NSRange(location: 0, length: nsString.length > 10 ? 10 : nsString.length))
        }else{
            return title
        }
    }
    
    func dateFormatter(date: String) -> String{
        let format = "yyyy-MM-dd"
        let format2 = "dd/MM/yyyy"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let y = dateFormatter.date(from: date)!
        dateFormatter.dateFormat = format2
        return dateFormatter.string(from: y)
    }
    
}

