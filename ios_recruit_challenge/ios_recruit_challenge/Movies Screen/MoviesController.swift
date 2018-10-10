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
    
    var movieView = MoviesView()
    let cellId = "cellId"
    var cellStatusList:[Bool] = [true,false,true,false,true,false,true,false,true,false,true,false]
    var loadingContent = false
    var actualPage = 1
    var lastPage = 10
    var movieTitleList:[String] = []
    var moviePosterUrlList:[String] = []
    var movieIdList:[String] = []
    
    override func viewDidLoad() {
        self.view.backgroundColor = .blue
        setup()
    }
    
    
    func setup(){
        movieView = MoviesView(frame: self.view.frame)
        movieView.collectionView.delegate = self
        movieView.collectionView.dataSource = self
        movieView.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        self.view.addSubview(movieView)
    }
    
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
        cell.favButton.tag = indexPath.row
        cell.favButton.addTarget(self, action: #selector(teste), for: .touchUpInside)
        cell.favButton.setImage(UIImage(named: "heart"), for: .normal)
        return cell
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
                    print(self.movieIdList)
                    self.movieView.collectionView.reloadData()
                    self.loadingContent = false
                }
            }
        }
        
    }
    
    
    @objc func teste(sender: UIButton){
        print("Ei")
    }
    
    func setBtnImage(index:Int) -> UIImage{
        if cellStatusList[index]{
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
    
}

