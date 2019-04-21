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
    var filterVC: BaseFilterViewController!
    var dm = DataModel.sharedInstance
    
    init(vc: BaseFilterViewController) {
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
            let year = String($0.date.split(separator: "-")[0])
            if !data.contains(year) {
                data.append(year)
            }
        }
        filterVC.updateLayout()
    }
    
}
