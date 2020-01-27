//
//  DAO.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 23/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation
import UIKit

let dao = DAO()
class DAO:Codable{
    var page = 1
    var cellWidth:CGFloat = 0
    let apiKey = "0c909c364c0bc846b72d0fe49ab71b83"
//    let fakeSearchURL = "https://api.themoviedb.org/3/search/movie?api_key=0c909c364c0bc846b72d0fe49ab71b83&query=Frozen"
    let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=0c909c364c0bc846b72d0fe49ab71b83&language=en-US&page=1"
    var searchURL = "https://api.themoviedb.org/3/search/movie?api_key=0c909c364c0bc846b72d0fe49ab71b83&query="
    
    var searchResults:[Movie] = []
    var favoriteMovies:[Movie] = []
    
    //MARK:- Colors
    var concreteDarkGray:String = "#2D3047"
    var concreteYellow:String = "#F7CE5B"
    var concreteDarkYellow:String = "#D9971E"
    var concreteWhite:String = "#FFFFFF"
    var concreteRed:String = "#FC1A03"
    
}
    
    
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
                    g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
                    b = CGFloat(hexNumber & 0x0000FF) / 255.0
                    a = CGFloat(1.0)

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
