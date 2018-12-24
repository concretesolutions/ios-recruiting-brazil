//
//  MovieView.swift
//  Movs
//
//  Created by Pedro Clericuzi on 19/12/2018.
//  Copyright © 2018 Pedro Clericuzi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieView: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let dataJSON = DataJSON()
    let core = DataBase()
    
    let identifier = "identifier"
    
    var arrayMovies:[Movies] = []
    
    var colView: UICollectionView!
    var mySearchBar:UISearchBar?
    var apiKey:String?
    var labelError:UILabel?
    var imageError:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        core.initCoreData()
        apiKey = UserDefaults.standard.string(forKey: "apiKey")!
        //getting the data
        data(url: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey!)&page=1", mySearchString: "")
        myGrid() // Creting the collectionView
        UserDefaults.standard.removeObject(forKey: "IdRow")
        searchBarMethod() //Creating the searchBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //After backing to Movies tag, is called this method to refresh the list
        data(url: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey!)&page=1", mySearchString: "")
    }
    
    //Method to get the JSON and convert to list
    func data(url:String, mySearchString:String) {
        self.dataJSON.getData(url: url) {(output) in
            if (output.count>0) {
                for list in output {
                    let jsonId = list["id"]  as? Int ?? 0
                    let jsonTitle = list["title"] as? String ?? ""
                    let jsonPoster = list["poster_path"] as? String ?? ""
                    self.arrayMovies.append(Movies(id: jsonId, name: jsonTitle, imageUrl: jsonPoster))
                    DispatchQueue.main.async {
                        self.colView!.reloadData()
                    }
                }
            } else {
                self.creatingMensage(icon: "search_icon.png", mensage:"Sua busca por \"\(mySearchString)\" não resultou em nenhum resultado")
            }
            
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath as IndexPath) as! GridCellClass
        let downloadURL = URL(string: "https://image.tmdb.org/t/p/w500\(self.arrayMovies[indexPath.row].imageUrl)")!
        cell.imageMovie.af_setImage(withURL: downloadURL)
        cell.labelMovieTitle.text = self.arrayMovies[indexPath.row].name
        
        let result = core.getSpecificFavorite(value: "\(self.arrayMovies[indexPath.row].id)")
        
        if result.count == 0 {
            cell.favoriteImg.image = UIImage(named: "favorite_empty_icon.png")
        } else {
            cell.favoriteImg.image = UIImage(named: "favorite_full_icon.png")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Creating an User default to save the Id to get in DetailsView
        let gridId = self.arrayMovies[indexPath.row].id
        UserDefaults.standard.set(gridId, forKey: "IdRow")
        let detailsView = DetailsView()
        self.navigationController?.pushViewController(detailsView, animated: false)
    }
    
    //Drawing the grind on the screen
    func myGrid() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 60, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 172, height: 222)
        
        colView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        colView.delegate   = self
        colView.dataSource = self
        let nibName = UINib(nibName: "GridCell", bundle:nil)
        colView.register(nibName, forCellWithReuseIdentifier: identifier)
        colView.backgroundColor = UIColor.white
        
        self.view.addSubview(colView)
    }
    //called to draw the search bar
    func searchBarMethod() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBarHeight = (navigationController?.navigationBar.frame.size.height)! + 20
        
        mySearchBar = UISearchBar(frame: CGRect(x: 0, y: navBarHeight, width: screenSize.size.width, height:50))
        self.mySearchBar!.delegate = self
        self.mySearchBar!.enablesReturnKeyAutomatically = false
        mySearchBar!.placeholder = "Search"
        UISearchBar.appearance().barTintColor = UIColor( red: CGFloat(217/255.0), green: CGFloat(151/255.0), blue: CGFloat(30/255.0), alpha: CGFloat(0.8) )
        self.view.addSubview(mySearchBar!)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    // called when cancel button is clicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        arrayMovies.removeAll()
        
        imageError?.isHidden=true
        labelError?.isHidden=true
        
        let myUrl = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey!)&page=1"
        data(url: myUrl, mySearchString: "")
        self.mySearchBar?.text = ""
        self.mySearchBar?.showsCancelButton = false
        self.mySearchBar?.endEditing(true)
    }
    
    // called when search button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        arrayMovies.removeAll()
        DispatchQueue.main.async {
            self.colView!.reloadData()
        }
        let mySearchString:String = (mySearchBar?.text)!
        if (mySearchBar?.text == "") {
            creatingMensage(icon: "error.png", mensage:"Ocorreu um erro. Por favor, tente novamente")
        } else {
            imageError?.isHidden=true
            labelError?.isHidden=true
            let textForUrl:String = mySearchString.replacingOccurrences(of: " ", with: "+")
            let myUrl = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey!)&query=\(textForUrl)"
            data(url: myUrl, mySearchString: mySearchString)
        }
        self.view.endEditing(true)
    }
    
    //when called it draw the mensage error in the screen
    func creatingMensage(icon:String, mensage:String){
        imageError?.isHidden=true
        labelError?.isHidden=true
        let screenSize: CGRect = UIScreen.main.bounds
        imageError = UIImageView(frame: CGRect(x: (screenSize.width * 0.5)-50,
                                               y: (screenSize.height * 0.3),
                                               width: 100,
                                               height: 100));
        
        
        imageError!.image = UIImage(named: icon)
        self.view.addSubview(imageError!)
        
        let posYTitle = (screenSize.height * 0.4) + 55 + 30 //Height image, distance image and navbar, distance to image
        labelError = UILabel(frame: CGRect(x: screenSize.width * 0.05,
                                           y: posYTitle,
                                           width: (screenSize.width * 0.9),
                                           height: 50))
        labelError?.font = UIFont(name: "Halvetica", size: 17)
        labelError?.textAlignment = .center
        labelError?.numberOfLines = 20;
        labelError?.lineBreakMode = .byWordWrapping
        labelError?.numberOfLines = 0
        labelError?.text = mensage
        labelError?.textColor = UIColor.black
        self.view.addSubview(labelError!)
    }
}
