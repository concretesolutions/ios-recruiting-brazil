//
//  Filter.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 03/11/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import Foundation

//Movies and TV SHOWS Filter object
struct Filter{
    var selectedGenresIds:Array<Int> = Array()
    var selectedYears:Array<String> = Array()
    
    mutating func insertGenre(g:Genre){
        if let existingIndex = selectedGenresIds.firstIndex(of: g.id){
            selectedGenresIds.remove(at: existingIndex)
        }else{
            selectedGenresIds.append(g.id)
        }
    }
    
    mutating func insertYear(y:String){
        if let existingIndex = selectedYears.firstIndex(of: y){
            selectedYears.remove(at: existingIndex)
        }else{
            selectedYears.append(y)
        }
    }
    
}
