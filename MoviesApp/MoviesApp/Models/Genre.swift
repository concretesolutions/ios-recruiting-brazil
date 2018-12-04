//
//  Genre.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 04/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import Foundation

extension Genre {
    convenience init(dictionary: [String:Any]) {
        self.init(context: AppDelegate.shared.persistentContainer.viewContext)
        id = Int64(Int(safeValue: dictionary["id"]))
        name = String(safeValue: dictionary["name"])
        AppDelegate.shared.saveContext()
    }
}
