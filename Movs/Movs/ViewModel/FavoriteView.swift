//
//  FavoriteView.swift
//  Movs
//
//  Created by Pedro Clericuzi on 19/12/2018.
//  Copyright © 2018 Pedro Clericuzi. All rights reserved.
//

import UIKit

class FavoriteView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myTableView:UITableView?
    var arrMovies:[Movies] = []
    var imageMovie: UIImageView?
    var movieTitle:UILabel?
    var linkBanda:UILabel?
    
    let core = DataBase()
    let dataJSON = DataJSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        core.initCoreData()
        self.mTableView()
        let xib = UINib(nibName: "TableCell", bundle: nil)
        self.myTableView!.register(xib, forCellReuseIdentifier: "identifierTable")
        let myFavorites = core.getFavorite()
        let apiKey = UserDefaults.standard.string(forKey: "apiKey")
        //Requesting in API the movie by id
        for itens in myFavorites {
            let idMovie:String = itens.value(forKey: "id") as! String;
            print(idMovie)
            let urlMovie = "http://api.themoviedb.org/3/movie/\(idMovie)?api_key=\(apiKey!)"
            myFavoriteMovies(url:urlMovie)
        }
        
    }
    
    func mTableView() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBarHeight = (navigationController?.navigationBar.frame.size.height)! + 20
        self.myTableView = UITableView(frame: CGRect(x: 0, y: navBarHeight+10, width: screenSize.width, height: (screenSize.height * 0.85)-navBarHeight))
        self.myTableView!.delegate = self
        self.myTableView!.dataSource = self
        self.view.addSubview(myTableView!)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableCellClass?
        cell = myTableView!.dequeueReusableCell(withIdentifier: "identifierTable") as? TableCellClass
        cell!.titleMovie.text = arrMovies[indexPath.row].name
        cell!.yearMovie.text = arrMovies[indexPath.row].year
        cell!.descriptionMovie.text = arrMovies[indexPath.row].description
        let downloadURL = URL(string: "https://image.tmdb.org/t/p/w500\(self.arrMovies[indexPath.row].imageUrl)")!
        cell!.imageMovie.af_setImage(withURL: downloadURL)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Creating an User default to save the Id to get in DetailsView
        let gridId = self.arrMovies[indexPath.row].id
        UserDefaults.standard.set(gridId, forKey: "IdRow")
        let detailsView = DetailsView()
        self.navigationController?.pushViewController(detailsView, animated: false)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Unfavorite") { action, index in
            self.core.deleteFavorite(id: "\(self.arrMovies[index.row].id)")
            self.arrMovies.remove(at: index.row)
            self.myTableView!.reloadData();
        }
        delete.backgroundColor = UIColor.red;
        return [delete]
    }
    
    //Method to get the JSON and convert to list
    func myFavoriteMovies(url:String) {
        self.dataJSON.getDetailsMovie(url: url) {(output) in
            DispatchQueue.main.async {
                let releaseDate = output["release_date"] as! String
                var splitDate = releaseDate.components(separatedBy: "-")
                let releaseYear: String = splitDate[0]
                
                self.arrMovies.append(Movies(id: output["id"] as! Int, name: output["original_title"] as! String, imageUrl: output["poster_path"] as! String, description: output["overview"] as! String, year: releaseYear))
                self.myTableView?.reloadData()
            }
        }
    }
}
