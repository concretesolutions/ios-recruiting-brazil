//
//  LocalDataSaving.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 27/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation

class LocalDataSaving {
    
    static let userDefaults = UserDefaults.standard
    
    static func store(data: MovieEntity, forKey key: String) {
        
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        //LocalDataSaving.createDirectory()
        
        //var favoriteMovies = [Int : MovieEntity]()
        //favoriteMovies[1] = data
        //let dict = favoriteMovies as NSDictionary
        
        

        //let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("FavoriteMovies.plist")
        
        let dictionary:[String:String] = ["key1" : "value1"]
        let path = Bundle.main.url(forResource: "FavoriteMovies", withExtension: "plist")
        do {
            let encodedData: Data = try NSKeyedArchiver.archivedData(withRootObject: dictionary, requiringSecureCoding: false)
            try encodedData.write(to: path!, options: .atomic)
        } catch {
            print(error)
        }
        //let succeed = NSKeyedArchiver.archiveRootObject(dictionary, toFile: (path?.absoluteString)!)
        //print(succeed)
//        
//        do {
//            let encodedData = data.toDict() as NSDictionary
//            //let encodedData = try encoder.encode(data)
//            //let encodedData: Data = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
//            
//            try encodedData.write(to: path!)
////            LocalDataSaving.userDefaults.set(encodedData, forKey: key)
////            LocalDataSaving.userDefaults.synchronize()
//        } catch {
//            print(error)
//        }

    }
    
    static func retrieve(forKey key: String) -> Any? {
        
        if let path = Bundle.main.path(forResource: "FavoriteMovies", ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path)
            //let movie = try? PropertyListDecoder().decode(MovieEntity.self, from: xml)
        {
            print(xml.description)
        }
        
//        if let decodedData = LocalDataSaving.userDefaults.data(forKey: key) {
//            do {
//                let decodedType = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decodedData)
////                let decodedType = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [handler(type.self) as! AnyObject.Type], from: decodedData)
//                return decodedType
//            } catch {
//                print("Retrieving data failed")
//            }
//        }
        return nil
    }
    
    static func createDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("FavoriteMovies")
        if !fileManager.fileExists(atPath: paths){
            try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
        }else{
            print("Already dictionary created.")
        }
    }
}
