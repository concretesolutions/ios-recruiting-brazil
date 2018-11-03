//
//  FavoritesTableManager.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 03/11/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

protocol FavoritesTableManagerDelegate{
    func mediaSelected(media:MediaItem)
}

class FavoritesTableManager:NSObject{
    
    var delegate:FavoritesTableManagerDelegate?
    
    var favoritedMovies:Array<MediaItem>
    var favoritedTvShows:Array<MediaItem>
    
    override init(){
        
        favoritedMovies = DatabaseWorker.shared.getFavorites(type: .movie)
        favoritedTvShows = DatabaseWorker.shared.getFavorites(type: .tv)
        
        super.init()
        
    }
    
    func reloadData(){
        favoritedMovies = DatabaseWorker.shared.getFavorites(type: .movie)
        favoritedTvShows = DatabaseWorker.shared.getFavorites(type: .tv)
    }
    
}

//MARK:- Table View
extension FavoritesTableManager:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0{
            return "Favorited Movies"
        }else{
            return "Favorited TV Shows"
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{//Movies
            return favoritedMovies.count
        }else{
            return favoritedTvShows.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mediaItem") as! MediaTableViewCell
        
        var currentMedia:MediaItem
        
        if(indexPath.section == 0){//Movies
            currentMedia = favoritedMovies[indexPath.row]
        }else{//TV Shows
            currentMedia = favoritedTvShows[indexPath.row]
        }
        
        cell.setMedia(mediaItem: currentMedia)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if(editingStyle == .delete){
            
            var mediaToUnfavorite:MediaItem
            
            if(indexPath.section == 0){//Movies
                mediaToUnfavorite = favoritedMovies[indexPath.row]
                favoritedMovies.remove(at: indexPath.row)
            }else{//TV Shows
                mediaToUnfavorite = favoritedTvShows[indexPath.row]
                favoritedTvShows.remove(at: indexPath.row)
            }
            
            DatabaseWorker.shared.removeMediaFromFavorites(media: mediaToUnfavorite)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .middle)
            tableView.endUpdates()
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectecMedia:MediaItem
        
        if(indexPath.section == 0){//Movies
            selectecMedia = favoritedMovies[indexPath.row]
        }else{//TV Shows
            selectecMedia = favoritedTvShows[indexPath.row]
        }
        
        delegate?.mediaSelected(media: selectecMedia)
        
    }
    
    
}

