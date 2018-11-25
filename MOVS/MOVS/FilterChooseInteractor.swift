//
//  FilterChooseInteractor.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 25/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit
import CoreData

class FilterChooseInteractor: NSObject {
    // MARK: - Properties
    // MARK: - Public
    var cellType: FilterFavoriteType
    var infos: [NSManagedObject]
    var checkedRow: Int?
    // MARK: - Private
    
    // MARK: - Init
    public init(cellType type: FilterFavoriteType){
        self.cellType = type
        if cellType == .genre {
            self.infos = CoreDataManager<Gener>().fetch()
        }else{
            self.infos = []
            for film in CoreDataManager<Film>().fetch(){
                if let releaseYear = film.release_date?.split(separator: "-").first {
                    if !self.infos.contains(where: { (element) -> Bool in
                        return (element as! Film).release_date?.split(separator: "-").first == releaseYear
                    }){
                        self.infos.append(film)
                    }
                }
            }
        }
    }
    
    public init(cellType type: FilterFavoriteType, withData data: Any){
        self.cellType = type
        if cellType == .genre {
            self.infos = CoreDataManager<Gener>().fetch()
            self.checkedRow = self.infos.firstIndex(of: data as! Gener)
        }else{
            self.infos = []
            for film in CoreDataManager<Film>().fetch(){
                if let releaseYear = film.release_date?.split(separator: "-").first {
                    if !self.infos.contains(where: { (element) -> Bool in
                        return (element as! Film).release_date?.split(separator: "-").first == releaseYear
                    }){
                        self.infos.append(film)
                    }
                }
            }
            self.checkedRow = self.infos.firstIndex(where: { (film) -> Bool in
                if let releaseYear = (film as! Film).release_date?.split(separator: "-").first {
                    return releaseYear == data as! String
                }
                return false
            })
        }
    }
    
    
    //MARK: - Functions
    //MARK: - Public
    func getDataChecked() -> NSManagedObject?{
        if let checkRow = self.checkedRow{
            return self.infos[checkRow]
        }else{
            return nil
        }
        
    }
}
