//
//  MediaItem.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 26/10/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import Foundation

protocol MediaItem {
    
    var id:Int {get}
    var evaluation:Float {get}
    var title:String {get}
    var poster:String? {get}
    var overview:String {get}
    var releaseDate:String {get}
    var genres:Array<Int> {get}
    var mediaType:MediaType {get}
    
    func getThumbnailUrl()->String
    func getPosterURL()->String
    func getYear()->String
    
}
