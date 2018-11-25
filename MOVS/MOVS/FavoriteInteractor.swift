//
//  FavoriteInteractor.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 24/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FavoriteInteractor: NSObject{
    // MARK: - Properties
    // MARK: - Public
    let coreDataManager = CoreDataManager<Film>()
    var isFiltering: Bool = false
    
    var films: [Film] {
        get {
            if isFiltering{
                return self.filteredFilms
            }else{
                return self.regularFilms
            }
        }
        
        set {
            if isFiltering{
                self.filteredFilms = newValue
            }else{
                self.regularFilms = newValue
            }
        }
    }
    
    // MARK: - Private
    private var regularFilms: [Film] = []
    private var filteredFilms: [Film] = []
    
    // MARK: - Init
    override init() {
        super.init()
        self.films = coreDataManager.fetch()
    }
    
    //MARK: - Functions
    //MARK: - Public
    func unfavorite(film: Film){
        coreDataManager.delete(object: film)
    }
    
    func reloadData(){
        self.films = coreDataManager.fetch()
    }
    
    func filterWith(name: String){
        self.films = self.regularFilms.filter({ (film) -> Bool in
            return film.title?.contains(name) ?? false
        })
    }
}
