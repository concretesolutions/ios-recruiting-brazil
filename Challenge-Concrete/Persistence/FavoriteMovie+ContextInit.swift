//
//  FavoriteMovie+ContextInit.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 11/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import CoreData

extension FavoriteMovie: PersistableObject {
    convenience init(id: Int64, title: String, year: String, descript: String, image: Data) {
        self.init(context: CoreDataManager.persistentContainer.viewContext)
        self.id = id
        self.title = title
        self.year = year
        self.descript = descript
        self.image = image
    }
}
