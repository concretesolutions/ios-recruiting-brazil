//
//  FavoriteViewModel.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//


import UIKit


//MARK: - Protocols
protocol FavoriteInterface{
    func loadFavorites()
    func loadImages(favs: [Favorite])
    func deleteFavorite(movie: Favorite, at row: Int)
    func searchFavorites(search: String?)
    func filterFavorites(filters: [String])
}


//MARK: - Init
class FavoriteViewModel{
    public var favorites = [Favorite]()
    public var images = [UIImage]()
    var crud: FavoriteCRUDInterface
    
    var isFiltering: Bool
    
    init(crud: FavoriteCRUDInterface) {
        self.crud = crud
        isFiltering = false
        loadFavorites()
    }
}


//MARK: - METHODS
extension FavoriteViewModel: FavoriteInterface{
    //Loads all the favorites and translate the data to images
    func loadFavorites(){
        images.removeAll()
        
        do{
            favorites = try crud.loadData()
            loadImages(favs: favorites)
        }catch{
            print("Nenhum favorito cadastrado")
        }
    }
    
    //Load the image of the favorites by the data in the database
    func loadImages(favs: [Favorite]){
        favs.forEach { (fav) in
            if let image = UIImage(data: fav.image!){
                images.append(image)
            }
        }
    }
    
    //Delete a favorite in a specific row
    func deleteFavorite(movie: Favorite, at row: Int){
        crud.deleteFavorite(movieForDeletion: movie)
        favorites.remove(at: row)
        images.remove(at: row)
    }
    
    //Filter the favorites in the screen by a input
    func searchFavorites(search: String?){
        var filterMoveis = [Favorite]()
        images.removeAll()
        
        if let text = search{
            filterMoveis = favorites.filter{
                favorite in
                return ((favorite.title?.contains(text))!)
            }
        }
        favorites = filterMoveis
        loadImages(favs: favorites)
    }
    
    //Filter the favorites by the filters in the filter screen
    func filterFavorites(filters: [String]){
        isFiltering = true
        var filterFavs = [Favorite]()
        
        images.removeAll()
        
        if  filters[0] != "Nenhum"{
            filterFavs = favorites.filter({ (fav) -> Bool in
                return (fav.date == filters[0])
            })
        }
        
        if  filters[1] != "Nenhum"{
            filterFavs = favorites.filter{
                favorite in
                return (favorite.genres!.contains(filters[1]))
            }
        }
        
        if !filterFavs.isEmpty{
            favorites = filterFavs
            loadImages(favs: favorites)
        }else{
            favorites.removeAll()
        }
    }
    
}
