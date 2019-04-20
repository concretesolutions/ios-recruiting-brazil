//
//  FilterPresenter.swift
//  movs
//
//  Created by Lorien Moisyn on 20/04/19.
//  Copyright © 2019 Auspex. All rights reserved.
//

import Foundation

class FilterPresenter {
    
    var data: [String] = []
    var filterVC: FilterViewController!
    var dm = DataModel.sharedInstance
    
    init(vc: FilterViewController) {
        filterVC = vc
    }
    
    func getGenres() {
        data.removeAll()
        dm.genres.forEach{ data.append($0.name) }
        filterVC.updateLayout()
    }
    
    func getYears() {
        data.removeAll()
        dm.movies.forEach{
            if !data.contains($0.title) {
                data.append($0.title)
            }
        }
        filterVC.updateLayout()
    }
    
}
