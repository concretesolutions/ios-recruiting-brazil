//
//  FavoriteMovie+ContextInit.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 11/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import CoreData

extension FavoriteMovie {
    convenience init() {
        self.init(context: CoreDataManager.persistentContainer.viewContext)
    }
}
