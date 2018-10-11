//
//  FavoritesController.swift
//  ios_recruit_challenge
//
//  Created by Lucas de Brito on 09/10/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FavoritesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    var favoritesView = FavoritesView()
    let cellId = "cellId"
    var favoriteMovieIndexList:[Int] = []
    var favoriteMovieArray:[FavoriteMovie] = []
    var movieIdList:[String] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUserData()
        favoritesView.tableView.reloadData()
        showTableViewPlaceHolder()
    }
    
    // MARK: - Setup View Function
    func setupView(){
        favoritesView = FavoritesView(frame: self.view.frame)
        favoritesView.tableView.delegate = self
        favoritesView.tableView.dataSource = self
        favoritesView.tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: cellId)
        self.view.addSubview(favoritesView)
    }
    
    // MARK: - Update view model
    func updateUserData(){
        if UserDefaultsManager.shared.isThereAnyFavoriteMovie{
            favoriteMovieArray = UserDefaultsManager.shared.favoriteMoviesArray
            favoriteMovieIndexList = UserDefaultsManager.shared.favoriteMoviesIndexArray
            movieIdList = UserDefaultsManager.shared.movieIdList
        }
    }
    
    // MARK: - TableView DataSource and Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! FavoritesTableViewCell
        cell.nameLabel.text = favoriteMovieArray[indexPath.row].movieTitle!
        cell.photoView.loadImage(urlString: "https://image.tmdb.org/t/p/w200/" + favoriteMovieArray[indexPath.row].moviePosterUrl!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getJsonData(url: "https://api.themoviedb.org/3/movie/" + favoriteMovieArray[indexPath.row].movieApiIndex! + "?api_key=25655d622412630c8d690077b4a564f6&language=en-US") { (response) in
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
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.favoriteMovieArray.remove(at: indexPath.row)
            self.favoriteMovieIndexList.remove(at: indexPath.row)
            UserDefaultsManager.shared.favoriteMoviesArray = favoriteMovieArray
            UserDefaultsManager.shared.favoriteMoviesIndexArray = favoriteMovieIndexList
            favoritesView.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            showTableViewPlaceHolder()
        }
    }
    
    // MARK: - Auxiliar functions
    func showTableViewPlaceHolder(){
        if favoritesView.tableView.numberOfRows(inSection: 0) == 0{
            let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            let messageLabel = UILabel(frame: rect)
            messageLabel.text = "Don`t you like any movie?!"
            messageLabel.backgroundColor = UIColor(white: 0.95, alpha: 1)
            messageLabel.textColor = UIColor.black
            messageLabel.font = UIFont.boldSystemFont(ofSize: 20)
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()
            self.favoritesView.tableView.backgroundView = messageLabel
            self.favoritesView.tableView.separatorStyle = .none
        } else {
            let view = UIView()
            view.backgroundColor = UIColor(white: 0.95, alpha: 1)
            self.favoritesView.tableView.backgroundView = view
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
    
}
