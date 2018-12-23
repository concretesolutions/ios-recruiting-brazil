//
//  DetailsView.swift
//  Movs
//
//  Created by Pedro Clericuzi on 19/12/2018.
//  Copyright © 2018 Pedro Clericuzi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailsView: UIViewController {
    
    let dataJSON = DataJSON()
    let core = DataBase()
    
    var apiKey:String?
    var idRow:Int?
    
    var image: UIImageView?
    var buttonFavorite: UIButton?
    var labelTitle:UILabel?
    var labelYear:UILabel?
    var labelGenre:UILabel?
    var labelDescription:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Movie"
        core.initCoreData()
        apiKey = UserDefaults.standard.string(forKey: "apiKey")
        idRow = UserDefaults.standard.integer(forKey: "IdRow")
        //Requesting in API the movie by id
        let urlMovie = "http://api.themoviedb.org/3/movie/\(idRow!)?api_key=\(apiKey!)"
        data(url:urlMovie)
    }
    
    func drawItemns(pathImage:String, movieTitle:String, releaseDate:String, movieGenres:String, movieOverview:String) {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let navBarHeight = (navigationController?.navigationBar.frame.size.height)! + 30
        self.image = UIImageView(frame: CGRect(x: screenSize.width * 0.05,
                                          y: navBarHeight,
                                          width: screenSize.width * 0.9,
                                          height: screenSize.height * 0.4));
        
        let downloadURL = URL(string: "https://image.tmdb.org/t/p/w500\(pathImage)")!
        self.image!.af_setImage(withURL: downloadURL)
        self.view.addSubview(self.image!)
        
        let stringValue = "\(idRow!)"
        let result = core.getSpecificFavorite(value: stringValue)
        
        var favIcon:UIImage?
        if result.count == 0 {
            favIcon = UIImage(named: "favorite_empty_icon.png")
        } else {
            favIcon = UIImage(named: "favorite_full_icon.png")
        }
        
        let posYTitle = (screenSize.height * 0.4) + 55 + 30 //Height image, distance image and navbar, distance to image
        self.labelTitle = UILabel(frame: CGRect(x: screenSize.width * 0.05,
                                               y: posYTitle,
                                               width: (screenSize.width * 0.9) - (favIcon?.size.width)!,
                                               height: 18))
        self.labelTitle?.font = UIFont(name: "Halvetica", size: 17)
        self.labelTitle?.text = "\(movieTitle)"
        self.labelTitle?.textColor = UIColor.black
        self.view.addSubview(self.labelTitle!)
        
        //Custom button with the Favorite image
        self.buttonFavorite = UIButton(frame: CGRect(x: (screenSize.width * 0.9) - (favIcon?.size.width)! + (screenSize.width * 0.05),
                                                y: posYTitle, //Height image, distance image and navbar, distance to image
                                                width: (favIcon?.size.width)!,
                                                height: (favIcon?.size.height)!))
        self.buttonFavorite?.setImage(favIcon, for: .normal)
        
        //Set the icon favorite, verify if is or not a favorite movie
        if result.count == 0 {
            self.buttonFavorite?.addTarget(self, action: #selector(btnFavorite), for: .touchUpInside)
        } else {
            self.buttonFavorite?.addTarget(self, action: #selector(btnUnfavorite), for: .touchUpInside)
        }
        
        self.view.addSubview(self.buttonFavorite!)
        //Method to put the line above title and button
        let posXView = screenSize.width * 0.05
        self.viewLine(posX:posXView, posY:posYTitle+30, widthView:screenSize.width)
        
        //Label with release year
        let posYRelease = posYTitle + 12 + 2 + 30 //Position Y labelTitle, distance of label and view(above), height of the view, distance to label(below)
        self.labelYear = UILabel(frame: CGRect(x: screenSize.width * 0.05,
                                                y: posYRelease,
                                                width: (screenSize.width * 0.9),
                                                height: 18))
        self.labelYear?.font = UIFont(name: "Halvetica", size: 17)
        var splitDate = releaseDate.components(separatedBy: "-")
        let releaseYear: String = splitDate[0]
        self.labelYear?.text = "\(releaseYear)"
        self.labelYear?.textColor = UIColor.black
        self.view.addSubview(self.labelYear!)
        
        self.viewLine(posX:posXView, posY:posYRelease+30, widthView:screenSize.width)
        
        //Label with release year
        let posYGenre = posYRelease + 12 + 2 + 30 //Position Y labelYear, distance of label and view(above), height of the view, distance to label(below)
        self.labelGenre = UILabel(frame: CGRect(x: screenSize.width * 0.05,
                                               y: posYGenre,
                                               width: (screenSize.width * 0.9),
                                               height: 18))
        self.labelGenre?.font = UIFont(name: "Halvetica", size: 17)
        
        self.labelGenre?.text = "\(movieGenres)"
        self.labelGenre?.textColor = UIColor.black
        self.view.addSubview(self.labelGenre!)
        
        self.viewLine(posX:posXView, posY:posYGenre+30, widthView:screenSize.width)
        
        //Label with release year
        let posYOverview = posYGenre + 12 + 2 + 30 //Position Y labelYear, distance of label and view(above), height of the view, distance to label(below)
        let difference = screenSize.height-posYOverview
        self.labelDescription = UILabel(frame: CGRect(x: screenSize.width * 0.05,
                                                y: posYOverview,
                                                width: (screenSize.width * 0.9),
                                                height: difference*0.7))
        self.labelDescription?.font = UIFont(name: "Halvetica", size: 10)
        self.labelDescription?.numberOfLines = 20;
        self.labelDescription?.lineBreakMode = .byWordWrapping
        self.labelDescription?.numberOfLines = 0
        self.labelDescription?.text = "\(movieOverview)"
        self.labelDescription?.textColor = UIColor.black
        self.view.addSubview(self.labelDescription!)
    }
    
    @objc func btnFavorite(){
        print("favoritou")
        let stringValue = "\(idRow!)"
        core.saveFavorite(id:stringValue)
        let favIcon = UIImage(named: "favorite_full_icon.png")
        buttonFavorite!.setImage(favIcon, for: .normal)
    }
    
    @objc func btnUnfavorite(){
        print("favoritou")
        let stringValue = "\(idRow!)"
        core.deleteFavorite(id:stringValue)
        let favIcon = UIImage(named: "favorite_empty_icon.png")
        buttonFavorite!.setImage(favIcon, for: .normal)
    }
    
    func viewLine(posX:CGFloat, posY:CGFloat, widthView:CGFloat) {
        let myView = UIView(frame: CGRect(x: posX, y: posY, width: widthView, height:2))
        myView.backgroundColor = UIColor(red: 0.04, green: 0.03, blue: 0.00, alpha: 0.13)
        self.view.addSubview(myView)
    }
    
    //Method to get the JSON and convert to list
    func data(url:String) {
        self.dataJSON.getDetailsMovie(url: url) {(output) in
            DispatchQueue.main.async {
                print(output["poster_path"]!)
                let getResultsGenres = output["genres"] as! [[String: Any]]
                let strGenres = self.getAllGenres(genres:getResultsGenres)
                
                let jsonPoster = output["poster_path"] as? String ?? ""
                let original_title = output["original_title"] as? String ?? ""
                let release_date = output["release_date"] as? String ?? ""
                let overview = output["overview"] as? String ?? ""
                
                self.drawItemns(pathImage: jsonPoster, movieTitle:original_title, releaseDate: release_date, movieGenres: strGenres, movieOverview: overview)
            }
        }
    }
    
    //Method to get genres the of movie
    func getAllGenres(genres:[[String: Any]]) -> String{
        var genresMovie = ""
        var i = 1
        for itens in genres {
            genresMovie += itens["name"] as! String
            if (i<genres.count){
                genresMovie += ", "
            }
            i = i + 1
        }
        return genresMovie
    }
}

