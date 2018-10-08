//
//  MovieFilter.swift
//  RMovie
//
//  Created by Renato Mori on 07/10/18.
//  Copyright © 2018 Renato Mori. All rights reserved.
//

import Foundation

class MovieFilter {
    var movies : [RM_Movie?];
    
    init(movies : [RM_Movie?]){
        self.movies = movies;
        moviesFilter = [];
    }
    // MARK: - Filter
    
    var moviesFilter : [RM_Movie?]?;
    var titleSearch : String = "";
    var yearMin : NSInteger?;
    var yearMax : NSInteger?;
    var genero : NSInteger?;
    
    func hasFilter() -> Bool{
        return yearMin != nil || yearMax != nil || genero != nil;
    }
    
    func applyFilters(){
        objc_sync_enter(self);
        moviesFilter = [RM_Movie]();
        
        for movie in movies {
            if(movie?.release_date == nil || (movie?.release_date?.count)! < 4){
                if (yearMin == nil || yearMax == nil){
                    continue;
                }
            }else{
                
                let movieYear : NSInteger = Int(String((movie?.release_date?.prefix(4))!))!;
                
                if(yearMin != nil && yearMin! > movieYear) {continue;}
                if(yearMax != nil && yearMax! < movieYear) {continue;}
            }
            if(genero != nil){
                var count = 0;
                for id in (movie?.genre_ids)! {
                    if(genero == id){
                        break;
                    }
                    count = count+1;
                }
                if(count == movie?.genre_ids.count){
                    continue;
                }
            }
            
            if(titleSearch.count > 0 && movie?.title?.contains(titleSearch) == false){
                continue;
            }
            
            moviesFilter?.append(movie);
        }
        objc_sync_exit(self);
    }
    
    var count : Int?{
        self.applyFilters();
        return moviesFilter?.count;
    }
    
    subscript(index:Int) -> RM_Movie?{
        self.applyFilters();
        if(index < (self.moviesFilter?.count)!){
            return self.moviesFilter![index];
        }
        return nil;
    }
}
