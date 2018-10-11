//
//  MovieDetailController.swift
//  ios_recruit_challenge
//
//  Created by Lucas de Brito on 10/10/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MovieDetailController: UIViewController {
    
    //MARK: - Properties
    var movieDetailView = MovieDetailView()
    var moviePosterUrl: String = ""
    var movieName: String = ""
    var movieOverview: String = ""
    var movieGenres:[String] = [ ]
    var movieRelaseDate: String = ""
    var favoriteMovieIndexList:[Int] = []
    var favoriteMovieArray:[FavoriteMovie] = []
    var movieIdList:[String] = []
    var movieGridIndex: Int = 0
    var movieApiIndex: Int = 0
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        updateUserData()
        setupView()
    }
    
    //MARK: - update user model
    func updateUserData(){
        if UserDefaultsManager.shared.isThereAnyFavoriteMovie{
            favoriteMovieArray = UserDefaultsManager.shared.favoriteMoviesArray
            favoriteMovieIndexList = UserDefaultsManager.shared.favoriteMoviesIndexArray
            movieIdList = UserDefaultsManager.shared.movieIdList
        }
    }
    
    //MARK: - Setup view
    func setupView(){
        self.view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        let vf = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 600)
        movieDetailView = MovieDetailView(frame: vf)
        let sv = UIScrollView(frame: self.view.frame)
        sv.contentSize.height = 605
        self.view.addSubview(sv)
        sv.addSubview(movieDetailView)
        movieDetailView.moviePosterView.loadImage(urlString: "https://image.tmdb.org/t/p/w500/" + moviePosterUrl)
        movieDetailView.movieNameLabel.text = movieName
        movieDetailView.movieDetailLabel.attributedText = showMovieInfo(overview: movieOverview,genres:movieGenres,releaseDate:movieRelaseDate)
        movieDetailView.favButton.setImage(setBtnImage(index: Int(movieIdList[movieGridIndex])!),for:.normal)
        movieDetailView.favButton.addTarget(self, action: #selector(editFavoriteList), for: .touchUpInside)
    }
    
    func showMovieInfo(overview:String, genres:[String], releaseDate:String) -> NSMutableAttributedString{
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: "Overview\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14),NSAttributedStringKey.foregroundColor:UIColor.black]))
        attributedText.append(NSAttributedString(string: overview + "\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14),NSAttributedStringKey.foregroundColor:UIColor.gray]))
        attributedText.append(NSAttributedString(string: "Genres\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14),NSAttributedStringKey.foregroundColor:UIColor.black]))
        let x = String(describing: genres).replacingOccurrences(of: "\"", with: "")
        let y = x.replacingOccurrences(of: "[", with: "")
        let z = y.replacingOccurrences(of: "]", with: "")
        attributedText.append(NSAttributedString(string: z + "\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14),NSAttributedStringKey.foregroundColor:UIColor.gray]))
        attributedText.append(NSAttributedString(string: "Release date\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14),NSAttributedStringKey.foregroundColor:UIColor.black]))
        attributedText.append(NSAttributedString(string: dateFormatter(date: releaseDate) + "\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14),NSAttributedStringKey.foregroundColor:UIColor.gray]))
        return attributedText
    }
    
    
    func fitMovieTitleIntoLabel(title: String) -> String{
        let nsString = title as NSString
        if nsString.length >= 20{
            return nsString.substring(with: NSRange(location: 0, length: nsString.length > 10 ? 10 : nsString.length))
        }else{
            return title
        }
    }
    
    //MARK: - Auxiliar functions
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
    
    func setBtnImage(index:Int) -> UIImage{
        if favoriteMovieIndexList.contains(index){
            return UIImage(named: "fullHeart")!
        }else{
            return UIImage(named: "heart")!
        }
    }
    
    @objc func editFavoriteList(){
        if favoriteMovieIndexList.contains(movieApiIndex){
            if let index = favoriteMovieIndexList.index(of: movieApiIndex){
                favoriteMovieIndexList.remove(at: index)
                favoriteMovieArray.remove(at: index)
                UserDefaultsManager.shared.favoriteMoviesArray = self.favoriteMovieArray
                UserDefaultsManager.shared.favoriteMoviesIndexArray = self.favoriteMovieIndexList
                movieDetailView.favButton.setImage(setBtnImage(index: Int(movieIdList[movieGridIndex])!),for:.normal)
            }
        }else{
            getJsonData(url: "https://api.themoviedb.org/3/movie/" + String(movieApiIndex) + "?api_key=25655d622412630c8d690077b4a564f6&language=en-US", completion: { (response) in
                let jsonResponse = JSON(response)
                let movieTitle = jsonResponse["title"].stringValue
                let moviePosterUrl = jsonResponse["poster_path"].stringValue
                let movieReleaseDate = jsonResponse["release_date"].stringValue
                let movieGenre = jsonResponse["genres"].arrayValue.map({$0["name"].stringValue})
                let movieApiIndex = jsonResponse["id"].stringValue
                let favoritedMovie = FavoriteMovie(movieTitle: movieTitle, moviePosterUrl: moviePosterUrl, movieReleaseDate: movieReleaseDate, movieGenre: movieGenre, movieApiIndex:movieApiIndex)
                self.favoriteMovieArray.append(favoritedMovie)
                self.favoriteMovieIndexList.append(self.movieApiIndex)
                UserDefaultsManager.shared.isThereAnyFavoriteMovie = true
                UserDefaultsManager.shared.favoriteMoviesArray = self.favoriteMovieArray
                UserDefaultsManager.shared.favoriteMoviesIndexArray = self.favoriteMovieIndexList
                self.movieDetailView.favButton.setImage(self.setBtnImage(index: Int(self.movieIdList[self.movieGridIndex])!),for:.normal)
            })
            
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
