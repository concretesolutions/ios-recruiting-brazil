//
//  DataStoreFavorite.swift
//  RMovie
//
//  Created by Renato Mori on 07/10/18.
//  Copyright © 2018 Renato Mori. All rights reserved.
//

import Foundation

class Favorite{
    static let store = Favorite()
    //var movies : [RM_Movie];
    var moviesFilter : MovieFilter;
    
    
    
    private init(){
        self.moviesFilter = MovieFilter(movies: []);
        self.loadData();
     }
    
    private var filePath : String{
        let manager = FileManager.default;
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first;
        return (url?.appendingPathComponent("DataStoreFavorite").path)!;
    }
    
    func addItem(item: RM_Movie) {
        if(item.id == nil){
            return;
        }
        self.moviesFilter.movies.append(item);
        self.saveData();
    }
    
    func hasId(id : NSInteger) -> Bool{
        var index = 0;
        for movie in self.moviesFilter.movies {
            if(movie!.id == id){
                return true;
            }
            index = index + 1;
        }
        return false;
    }
    
    func removeItem(item : RM_Movie){
        var index = 0;
        for movie in self.moviesFilter.movies {
            if(movie!.id == item.id){
                self.moviesFilter.movies.remove(at: index)
                self.saveData();
                break;
            }
            index = index + 1;
        }
        
    }
    
    private func saveData(){
        var storeData = [NSDictionary]();
        for movie in self.moviesFilter.movies {
            storeData.append(movie!.JSON);
        }
        
        NSKeyedArchiver.archiveRootObject(storeData, toFile: filePath)
    }
    
    private func loadData(){
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [NSDictionary] {
            self.moviesFilter.movies = [];
            for data in ourData{
                self.moviesFilter.movies.append(RM_Movie(JSON: data));
            }
        }
    }
    
    
    
}
