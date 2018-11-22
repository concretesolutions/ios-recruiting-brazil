//
//  FilterManager.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 21/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import Foundation

public class FilterManager{
    
    static let shared = FilterManager()
    
    var releaseDates = [String]()
    var genders = [Genre]()
    
    init() {
        releaseDates = []
        genders = []
    }
    
}


