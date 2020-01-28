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
final class DAO:Codable{
    
    
    //MARK: Api info
    var page = 1
    var cellWidth:CGFloat = 0
    let apiKey = "0c909c364c0bc846b72d0fe49ab71b83"
    let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=0c909c364c0bc846b72d0fe49ab71b83&language=en-US&page=1"
    var searchURL = "https://api.themoviedb.org/3/search/movie?api_key=0c909c364c0bc846b72d0fe49ab71b83&query="
    
    //MARK:- Data Storage
    var searchResults:[Movie] = []
    var favoriteMovies:[Movie] = []
    var filteredFavorites:[Movie] = []
    var filteredMovies:[Movie] = []
    
    
    
    
    //MARK:- Colors
//    var concreteDarkGray:String = "#2D3047"
    var concreteGray:String = "#5A648A"
    var concreteYellow:String = "#F7CE5B"
    var concreteDarkYellow:String = "#D9971E"
    var concreteWhite:String = "#FFFFFF"
    var concreteRed:String = "#FC1A03"
//    var concretePurple = "#451c88"
    var concreteDarkGray = "#0F1B4D"
    
    
    //MARK: - Error Messager
    func displayError(title:String,message:String,view:UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        view.present(alert, animated: true)
    }
    

    //MARK: - Data Saving Methods
    func saveFavorites() {
           do {
               try dao.favoriteMovies.save(inFileNamed: "favoritesJson")
           } catch {
               debugPrint("Cant save favorites")
           }
       }

       func retrieveFavorites() {
           do {
               try dao.favoriteMovies.loadFrom(fileSystem: "favoritesJson")
           } catch {
               debugPrint("Cant load favorites")
           }
       }
       
    
}
    
//MARK: - Extensions
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
extension Encodable {

        /**
         Save information from the `Codable` Object.
         
         - Parameters:
            - file: Name of the file .
         
         - Throws:
        StorageError.failedToWrite
         
         */
        func save(inFileNamed file: String? = nil) throws {
            
            let fileName = file ?? String(describing: self)
            
            let url = URL(fileURLWithPath: (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent( fileName + ".json"))
            
            
            let data = try JSONEncoder().encode(self)
            
            do{
                try data.write(to: url)
            }catch{
                throw error
            }
        }
    }

extension Decodable {
        
        /**
         Loads information from the `Codable` Object from Domain.
         
         - Parameters:
            - fileSystem: Name of the file .
         
         - Throws:
         StorageError.failedToRead or StorageError.failedToDecode
         */
        mutating func loadFrom(fileSystem file: String? = nil) throws {
            
            let fileName = file ?? String(describing: self)
            let url = URL(fileURLWithPath: (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent( fileName + ".json"))
            
            try load(fromURL: url)
        }

    mutating func load(fromURL url: URL) throws {
          
          var readedData:Data!
          do {
              readedData = try Data(contentsOf: url)
          } catch  {
              throw error
          }
          do {
              self = try JSONDecoder().decode(Self.self, from: readedData)
          } catch {
              throw error
          }
      }
    
}

//MARK: - Enums

enum SearchType{
    case title
    case genre
    case release
}

