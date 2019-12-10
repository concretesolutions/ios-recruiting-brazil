//
//  DetailMovieViewController.swift
//  RecruitingChallenge
//
//  Created by Giovane Barreira on 12/8/19.
//  Copyright © 2019 Giovane Barreira. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Realm
import RealmSwift

protocol PassDataDelegate {
    var getIndex: IndexPath {get}
    var moviesArray: [MoviesModel] {get}
}

class DetailMovieViewController: UIViewController {
    @IBOutlet weak var uiImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var detailCellArray: [MoviesModel] = []
    var indexCell : IndexPath?
    var delegateMovies: PassDataDelegate?
    var posterImg: UIImage?
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm()
        indexCell = delegateMovies?.getIndex
        detailCellArray = delegateMovies!.moviesArray
        navigationItem.title = "Movie Detail"
        tableView.dataSource = self
        tableView.delegate = self
        registerAllCells()
        getCachedImage()
        
        print(Realm.Configuration.defaultConfiguration.fileURL)

    }
    
    func saveRealm () {
        
        let movieSelected = detailCellArray[indexCell!.row]
        let imageToData = posterImg?.pngData()
        
        let favoriteMovie = RealmModel()
        favoriteMovie.movieTitle = movieSelected.movieTitle
        favoriteMovie.movieDesc = movieSelected.overview
        favoriteMovie.year = movieSelected.year
        favoriteMovie.posterImage = imageToData
        
        try! realm.write {
            realm?.add(favoriteMovie)
        }
        
    }
        
    func getCachedImage() {
        Alamofire.request(detailCellArray[indexCell!.row].posterImage).responseImage { (response) in
            if let movieImage = response.result.value {
                self.posterImg = movieImage
                DispatchQueue.main.async {
                    self.uiImage.image = self.posterImg
                }
            }
        }
    }
    
    func registerAllCells() {
        let nibCellFavorite = UINib(nibName: "FavoriteCell", bundle: nil)
        tableView.register(nibCellFavorite, forCellReuseIdentifier: "favoriteCell")
        
        let nibCellYear = UINib(nibName: "YearCell", bundle: nil)
        tableView.register(nibCellYear, forCellReuseIdentifier: "yearCell")
        
        let nibCellGenre = UINib(nibName: "GenreCell", bundle: nil)
        tableView.register(nibCellGenre, forCellReuseIdentifier: "genreCell")
        
        let nibCellDescription = UINib(nibName: "DescriptionCell", bundle: nil)
        tableView.register(nibCellDescription, forCellReuseIdentifier: "descCell")
    }
    
}
extension DetailMovieViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movieSelected = detailCellArray[indexCell!.row]
        let emptyCell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            let favorite = createCell(indentifierCell: "favoriteCell") as! FavoriteCell
            favorite.movieTitle.text = movieSelected.movieTitle
            favorite.delegate = self
            return favorite
        case 1:
            let year = createCell(indentifierCell: "yearCell") as! YearCell
            year.yearLbl.text = movieSelected.year
            return year
            
        case 2:
            let genre = createCell(indentifierCell: "genreCell") as! GenreCell
            let arrayToString = movieSelected.genreNames.joined(separator:", ")
            genre.genreLbl.text = arrayToString
            return genre
        case 3:
            let description = createCell(indentifierCell: "descCell") as! DescriptionCell
            description.movieDescription.text = movieSelected.overview
            return description
            
        default:
            break
        }
        tableView.reloadData()
        return emptyCell
    }
    
    func createCell(indentifierCell: String) -> UITableViewCell {
        var cell: UITableViewCell!
        if let createCell = tableView.dequeueReusableCell(withIdentifier: indentifierCell) {
            cell = createCell
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70
        } else if indexPath.section == 3 {
            return 400
        } else {
            return 40
        }
    }
}

extension DetailMovieViewController: CellDelegate {
    func didTap(_ cell: FavoriteCell, favoriteTapped: Bool) {
        if favoriteTapped {
             saveRealm()
        }
    }
}
